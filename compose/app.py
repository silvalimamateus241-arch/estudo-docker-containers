from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
import os
import time

app = Flask(__name__)

# Função para aguardar o banco de dados estar pronto
def get_db_connection():
    retries = 10
    while retries > 0:
        try:
            conn = mysql.connector.connect(
                connection_timeout=5,
                host=os.getenv('DB_HOST', 'db'), # O nome do serviço no docker-compose
                user=os.getenv('DB_USER', 'aluno'),
                password=os.getenv('DB_PASSWORD', 'aluno123'),
                database=os.getenv('DB_NAME', 'escola')
            )
            return conn
        except mysql.connector.Error as err:
            print(f"Erro ao conectar ao banco de dados: {err}")
            retries -= 1
            time.sleep(3) # Espera 3 segundos antes de tentar novamente
    return None

@app.route('/')
def index():
    conn = get_db_connection()
    if conn is None:
        return "<h1>Erro: Não foi possível conectar ao banco de dados.</h1><p>Verifique os logs do container da aplicação.</p>", 500

    cursor = None
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Buscar estudantes
        cursor.execute("SELECT * FROM estudantes ORDER BY id DESC")
        estudantes = cursor.fetchall()
        
        return render_template('index.html', estudantes=estudantes)
    except Exception as e:
        app.logger.exception("Erro ao consultar estudantes")
        return "Erro ao consultar o banco de dados.", 500
    finally:
        if conn.is_connected():
            if cursor is not None:
                cursor.close()
            conn.close()

@app.route('/adicionar', methods=['POST'])
def adicionar_estudante():
    nome = request.form['nome']
    email = request.form['email']
    curso = request.form['curso']
    
    conn = get_db_connection()
    if conn is None:
        return "<h1>Erro: Não foi possível conectar ao banco de dados para inserção.</h1>", 500

    cursor = None
    try:
        cursor = conn.cursor()
        
        cursor.execute(
            "INSERT INTO estudantes (nome, email, curso, data_matricula) VALUES (%s, %s, %s, CURDATE())",
            (nome, email, curso)
        )
        
        conn.commit()
        return redirect(url_for('index'))
    except Exception as e:
        conn.rollback()
        app.logger.exception("Erro ao adicionar estudante")
        return "Não foi possível cadastrar. Verifique se o e-mail já está cadastrado.", 400
    finally:
        if conn.is_connected():
            if cursor is not None:
                cursor.close()
            conn.close()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=False)
