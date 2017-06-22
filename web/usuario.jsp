<%@taglib tagdir="/WEB-INF/tags" prefix="tagsProject"%>
<tagsProject:verificaSessao/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="cabecalho.jsp"/>
<form id="formUsuario" method="get" action="Usuario">
    <c:choose>
        <c:when test="${param.acao eq 'novo'}">

            <h1>Inser��o de usu�rios</h1>
            </br>
            <div class="campos">
                <label for="usuario">Usu�rio.:</label>
                <input type="text" name="usuario" required="true" size="10" maxlength="10"/>
            </div>
            <div class="campos">
                <label for="senha">Senha.:</label>
                <input type="password" name="senha" id="senha2" required="true" size="10" maxlength="10" />
            </div>
            <div class="campos">
                <label for="senha">Repitir Senha.:</label>
                <input oninput="validarSenha(this)" type="password" name="senha1"  required="true" size="10" maxlength="10"/>
            </div>
            <div class="campos">
                <label for="nivel">N�vel.:</label>
                <input type="number" min="1" max="3" name="nivel" required="true" size="1" maxlength="1"/></br> 1-b�sico, 2-intermedi�rio, 3-administrador;
            </div>
            <div class="campos">
                <label for="nomecompleto">Nome Completo.:</label>
                <input type="text" name="nomecompleto" required="true" size="20" maxlength="30"/>
            </div>
            <input type="submit" name="acao" value="novo" class="botao"/>
        </c:when>
        <c:otherwise>
            <h1>Altera��o de usu�rios</h1>
            </br>
            <div class="campos">
                <label for="usuario">Usu�rio.:</label>
                <input type="text" name="usuario" value="${param.usuario}" readonly="true" size="10"/>
            </div>
            <div class="campos">
                <label for="senha">Senha.:</label>
                <input type="password" name="senha" id="senha" value="${param.senha}" required="true" size="10" maxlength="10"/>
            </div>
            <div class="campos">
                <label for="senha">Repitir Senha.:</label>
                <input oninput="validarSenha(this)" type="password" name="senha1" required="true" size="10" maxlength="10"/>
            </div>
            <div class="campos">
                <label for="nivel">N�vel.:</label>
                <input type="number" min="1" max="3" name="nivel" value="${param.nivel}" required="true" size="1" maxlength="1"/></br>1-b�sico, 2-intermedi�rio, 3-administrador;
            </div>
            <div class="campos">
                <label for="nomecompleto">Nome Completo.:</label>
                <input type="text" name="nomecompleto" value="${param.nomecompleto}" required="true" size="20" maxlength="30"/>
            </div>
            <input type="submit" name="acao" value="alterar" class="botao"/>
        </c:otherwise>
    </c:choose>
</form>

<c:import url="rodape.jsp"/>