package br.com.projeto.factory;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionFactory {

    public static Connection conector() {
        java.sql.Connection conexao = null;
        // a linha abaixo "chama" o driver
        String driver = "com.mysql.jdbc.Driver";
        // Armazenando informações referente ao banco
        String url = "jdbc:mysql://localhost:3306/dbprojeto";
        String user = "root";
        String password = "";
        // Estabelecendo a conexão com o banco
        try {
            Class.forName(driver);
            conexao = DriverManager.getConnection(url, user, password);
            return conexao;
        } catch (Exception e) {
            //a linha a baixo serve de apoio para esclarecer o erro
            //System.out.println(e);
            return null;
        }
    }
}
