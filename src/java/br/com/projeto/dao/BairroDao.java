
package br.com.projeto.dao;

import br.com.projeto.factory.ConnectionFactory;
import br.com.projeto.javabean.model.BairroModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BairroDao {
     private Connection connection;

    public BairroDao() {
        this.connection = new ConnectionFactory().conector();
    }
    
    public List getListaBairroPaginada(int pagina, String ordenacao, String pesquisa, String campoapesquisar) throws SQLException {
        int limite = 10;
        int offset = (pagina * limite) - limite;
        String sql = "";
        if (campoapesquisar.equals("baiCodigo")) {
            sql = "select * from bairro where " + campoapesquisar + " = " + pesquisa + " order by " + ordenacao + " limit 10 offset " + offset;
        } else {
            sql = "select * from bairro where " + campoapesquisar + " like '%" + pesquisa + "%' order by " + ordenacao + " limit 10 offset " + offset;
        }
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        List<BairroModel> listaBairro = new ArrayList<BairroModel>();

        try {
            ps = connection.prepareStatement(sql);
            resultSet = ps.executeQuery();
            while (resultSet.next()) {
                BairroModel bairro = new BairroModel();
                bairro.setBaiCodigo(resultSet.getInt("baiCodigo"));
                bairro.setBaiDescricao(resultSet.getString("baiDescricao"));
                listaBairro.add(bairro);
            }
            return listaBairro;
        } catch (SQLException ex) {
            Logger.getLogger(BairroDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            //connection.close();
            //ps.close();
            //resultSet.close();
        }
        return null;
    }

    //MÉTODO PARA RETORNAR O NÚMERO TOTAL DE REGISTROS PARA PAGINAÇÃO
    public int totalRegistros(String pesquisa, String campoapesquisar) throws SQLException {
        PreparedStatement psConta = null;
        ResultSet resultSetConta = null;
        String sqlConta = "";
        try {
            if (campoapesquisar.equals("baiCodigo")) {
                sqlConta = "select count(*) as contaRegistros from bairro where " + campoapesquisar + " = " + pesquisa;
                System.out.println(sqlConta);
            } else {
                sqlConta = "select count(*) as contaRegistros from bairro where " + campoapesquisar + " like '%" + pesquisa + "%'";
            }
            psConta = connection.prepareStatement(sqlConta);
            resultSetConta = psConta.executeQuery();
            resultSetConta.next();
            int qtdTotalRegistros = Integer.parseInt(resultSetConta.getString("contaRegistros"));
            return qtdTotalRegistros;
        } catch (SQLException ex) {
            Logger.getLogger(BairroDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connection.close();
            psConta.close();
            resultSetConta.close();
        }
        return 0;
    }
    
    //excluir bairro usando Model Bairros
    public boolean excluirBairro(BairroModel bairro) throws SQLException {
        String sql = "delete from bairro where baiCodigo = ?";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, bairro.getBaiCodigo());
            ps.execute();
            return true;
        } catch (SQLException erro) {
            Logger.getLogger(BairroDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();
        }

        return false;
    }
    
     //Altera o bairro
    public void alterarBairro(BairroModel bairro) throws SQLException {
        String sql = "update bairro set baiDescricao = ? where baiCodigo = ?";
        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, bairro.getBaiDescricao());
            ps.setInt(2, bairro.getBaiCodigo());
            ps.execute();
        } catch (SQLException erro) {
            Logger.getLogger(BairroDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();

        }

    }

    public void novoBairro(BairroModel bairro) throws SQLException {
        String sql = "insert into bairro(baiCodigo, baiDescrucao) values(?,?)";
        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, bairro.getBaiCodigo());
            ps.setString(2, bairro.getBaiDescricao());
            ps.execute();
        } catch (SQLException erro) {
            Logger.getLogger(BairroDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();

        }
    }
    
}
