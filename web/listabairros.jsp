
<%@taglib tagdir="/WEB-INF/tags" prefix="tagsProject"%>
<tagsProject:verificaSessao/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="cabecalho.jsp"/>
<h1>Lista de Bairros</h1>
<tagsProject:listaBairrosTablePaginada/>
<c:import url="rodape.jsp"/>