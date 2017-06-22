<%@taglib tagdir="/WEB-INF/tags" prefix="tagsProject"%>
<tagsProject:verificaSessao/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="cabecalho.jsp"/>
<form id="formUsuario" method="get" action="Usuario">
    <c:choose>
        <c:when test="${param.acao eq 'novo'}">

            <h1>Inserção de bairros</h1>
            </br>
            <div class="campos">
                <label for="usuario">Descrição.:</label>
                <input type="text" name="codDescricao" required="true" size="10" maxlength="10"/>
            </div>
            <input type="submit" name="acao" value="novo" class="botao"/>
        </c:when>
        <c:otherwise>
            <h1>Alteração de bairros</h1>
            </br>
            <div class="campos">
                <label for="usuario">Código.:</label>
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
                <label for="nivel">Nível.:</label>
                <input type="number" min="1" max="3" name="nivel" value="${param.nivel}" required="true" size="1" maxlength="1"/></br>1-básico, 2-intermediário, 3-administrador;
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