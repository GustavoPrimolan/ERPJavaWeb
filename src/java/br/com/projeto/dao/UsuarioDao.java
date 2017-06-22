package br.com.projeto.dao;

import br.com.projeto.factory.ConnectionFactory;
import br.com.projeto.javabean.model.UsuariosModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsuarioDao {

    private Connection connection;

    public UsuarioDao() {
        this.connection = new ConnectionFactory().conector();
    }

    //Só verifica se existe ou não existe
    public boolean verificaUsuario(UsuariosModel usuarios) {
        String sql = "select * from usuarios where usuario = ? and senha = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, usuarios.getUsuario());
            ps.setString(2, usuarios.getSenha());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException erro) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, erro);
        }

        return false;
    }

    //Retorna a linha do banco de dados
    public UsuariosModel getUsuario(String usuario, String senha) throws SQLException {
        String sql = "select * from usuarios where usuario=? and senha=?";

        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, senha);
            resultSet = ps.executeQuery();
            if (resultSet.next()) {
                UsuariosModel usuarios = new UsuariosModel();
                usuarios.setUsuario(usuario);
                usuarios.setSenha(senha);
                usuarios.setNivel(resultSet.getInt("nivel"));
                usuarios.setNomeCompleto(resultSet.getString("nomecompleto"));
                return usuarios;
            }

        } catch (SQLException erro) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();
            //resultSet.close();
        }

        return null;
    }

    //Retorna a lista com todos os usuarios
    public List getListaUsuarios() throws SQLException {
        String sql = "select * from usuarios";
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        List<UsuariosModel> listaUsuarios = new ArrayList<UsuariosModel>();

        try {
            ps = connection.prepareStatement(sql);
            resultSet = ps.executeQuery();
            while (resultSet.next()) {
                UsuariosModel usuarios = new UsuariosModel();
                usuarios.setUsuario(resultSet.getString("usuario"));
                usuarios.setSenha(resultSet.getString("senha"));
                usuarios.setNivel(resultSet.getInt("nivel"));
                usuarios.setNomeCompleto(resultSet.getString("nomecompleto"));
                listaUsuarios.add(usuarios);
            }
            return listaUsuarios;
        } catch (SQLException erro) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, erro);

        } finally {
            //connection.close();
            //ps.close();
            //resultSet.close();
        }
        return null;
    }

    public List getListaUsuariosPaginada(int pagina, String ordenacao, String pesquisa, String campoapesquisar) throws SQLException {
        int limite = 10;
        int offset = (pagina * limite) - limite;
        String sql = "";
        if (campoapesquisar.equals("nivel")) {
            sql = "select * from usuarios where " + campoapesquisar + " = " + pesquisa + " order by " + ordenacao + " limit 10 offset " + offset;
        } else {
            sql = "select * from usuarios where " + campoapesquisar + " like '%" + pesquisa + "%' order by " + ordenacao + " limit 10 offset " + offset;
        }
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        List<UsuariosModel> listaUsuarios = new ArrayList<UsuariosModel>();

        try {
            ps = connection.prepareStatement(sql);
            resultSet = ps.executeQuery();
            while (resultSet.next()) {
                UsuariosModel usuarios = new UsuariosModel();
                usuarios.setUsuario(resultSet.getString("usuario"));
                usuarios.setSenha(resultSet.getString("senha"));
                usuarios.setNivel(resultSet.getInt("nivel"));
                usuarios.setNomeCompleto(resultSet.getString("nomecompleto"));
                listaUsuarios.add(usuarios);
            }
            return listaUsuarios;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, ex);
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
            if (campoapesquisar.equals("nivel")) {
                sqlConta = "select count(*) as contaRegistros from usuarios where " + campoapesquisar + " = " + pesquisa;
                System.out.println(sqlConta);
            } else {
                sqlConta = "select count(*) as contaRegistros from usuarios where " + campoapesquisar + " like '%" + pesquisa + "%'";
            }
            psConta = connection.prepareStatement(sqlConta);
            resultSetConta = psConta.executeQuery();
            resultSetConta.next();
            int qtdTotalRegistros = Integer.parseInt(resultSetConta.getString("contaRegistros"));
            return qtdTotalRegistros;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connection.close();
            psConta.close();
            resultSetConta.close();
        }
        return 0;
    }

    //excluir usuarios usando Model UsuariosModel
    public boolean excluirUsuario(UsuariosModel usuarios) throws SQLException {
        String sql = "delete from usuarios where usuario = ?";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, usuarios.getUsuario());
            ps.execute();
            return true;
        } catch (SQLException erro) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();
        }

        return false;
    }

    //excluir usuarios usando varial String
    public boolean excluirUsuario1(String usuarios) throws SQLException {
        String sql = "delete from usuarios where usuario = ?";
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, usuarios);
            ps.execute();
            return true;
        } catch (SQLException erro) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();
        }
        return false;
    }

    //Altera o usuario
    public void alterarUsuario(UsuariosModel usuarios) throws SQLException {
        String sql = "update usuarios set senha = ?, nivel = ?, nomecompleto = ? where usuario = ?";
        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, usuarios.getSenha());
            ps.setInt(2, usuarios.getNivel());
            ps.setString(3, usuarios.getNomeCompleto());
            ps.setString(4, usuarios.getUsuario());
            ps.execute();
        } catch (SQLException erro) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();

        }

    }

    public void novoUsuario(UsuariosModel usuarios) throws SQLException {
        String sql = "insert into usuarios(usuario, senha, nivel, nomecompleto) values(?,?,?,?)";
        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, usuarios.getUsuario());
            ps.setString(2, usuarios.getSenha());
            ps.setInt(3, usuarios.getNivel());
            ps.setString(4, usuarios.getNomeCompleto());
            ps.execute();
        } catch (SQLException erro) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, null, erro);
        } finally {
            //connection.close();
            //ps.close();

        }
    }

}
