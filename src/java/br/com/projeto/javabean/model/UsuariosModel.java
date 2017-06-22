
package br.com.projeto.javabean.model;

public class UsuariosModel {
    private String usuario = null;
    private String senha = null;
    private int nivel;
    private String nomeCompleto = null;
    
    public boolean verificaUsuario(){
        if(this.usuario != null && this.senha != null){
            if(this.usuario.equals("admin") && this.senha.equals("admin"))
                return true;
        }
        return false;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }
    
}
