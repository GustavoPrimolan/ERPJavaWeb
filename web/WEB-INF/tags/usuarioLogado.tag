<%@tag body-content ="empty"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:choose>
    <c:when test="${nomeCompleto != null}">
        Usuário: ${nomeCompleto}
    </c:when>
    <c:otherwise>
        Usuário: Não logado
    </c:otherwise>
</c:choose>