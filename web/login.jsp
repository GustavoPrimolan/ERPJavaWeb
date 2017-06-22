<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="cabecalho.jsp"/>
<%@taglib tagdir="/WEB-INF/tags/" prefix="tagsProject" %>
<form action="Logar" method="get">
    <table border="1" id="login">
        <tr>
            <td colspan="2"><h1>Acesso ao Sistema</h1></td>
        </tr>
        <tr>
            <td><label>Usuário.:</label></td>
            <td><input autofocus placeholder="Usuário" required="true" type="text" name="usuario"/></td>
        </tr>
        <tr>
            <td><label>Senha.:</label></td>
            <td><input placeholder="Senha" required="true" type="password" name="senha"/></td>
        </tr>
        <tr>
            <td><input type="reset" value="Limpar"></td>
            <td><input type="submit" name="acessar" value="Acessar"></td>
        </tr>
        <tr>
            <td colspan="2"><h1><tagsProject:statusUsuarioSenha/></h1></td>
        </tr>
           
    </table>
</form>
<c:import url="rodape.jsp"/>