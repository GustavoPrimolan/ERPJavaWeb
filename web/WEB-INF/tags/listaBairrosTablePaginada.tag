<%@tag body-content="empty"%>
<%
    int limite = 10;
    String numPagina = request.getParameter("numpagina");
    if (numPagina == null) {
        numPagina = "1";
    }

    java.util.List listaDeBairros = (java.util.List) request.getAttribute("sessaoListaBairroPaginada");

    String ordenacao = request.getParameter("ordenacao");
    if (ordenacao == null) {
        ordenacao = "baiDescricao";
    }

    String pesquisa = request.getParameter("pesquisa");
    if (pesquisa == null) {
        pesquisa = "";
    }

    String campoapesquisar = request.getParameter("campoapesquisar");
    if (campoapesquisar == null) {
        campoapesquisar = "baiDescricao";
    }

    out.println("<table border='1'>");
    out.println("<form action='Bairro' method='get'>");
    out.println("<tr class='linha-especial-table'><td colspan='4'>");
    out.println("<select name='campoapesquisar'>");
    if (campoapesquisar.equals("baiDescricao")) {
        out.println("<option selected='selected' value='baiDescricao'>Descrição</option>");
    } else {
        out.println("<option value='baiDescricao'>Descrição</option>");
    }
    if (campoapesquisar.equals("baiCodigo")) {
        out.println("<option selected='selected' value='baiCodigo'>Código</option>");
    } else {
        out.println("<option value='baiCodigo'>Código</option>");
    }
    out.println("</select>");
    out.println("</br>");
    out.println("<input placeholder='Localizar' type='text' name='pesquisa'/></br>");
    out.println("<input type='hidden' name='acao' value='listarBairro'/>");
    out.println("<input type='image' src='imagens/localizar.png' width='40px' height='40px'/></td></tr>");
    out.println("</form>");
    out.println("<tr><td colspan='4'><a href='bairro.jsp?acao=novo'><img src='imagens/novo.png'/></a></td></tr>");
    out.println("<tr class='linha-especial-table'>");
    out.println("<td><a href='Bairro?pesquisa=" + pesquisa + "&campoapesquisar=" + campoapesquisar + "&acao=listarBairro&ordenacao=baiCodigo&numpagina=" + Integer.parseInt(numPagina) + "'>Código</a></td><td><a href='Bairro?pesquisa=" + pesquisa + "&campoapesquisar=" + campoapesquisar + "&acao=listarBairro&ordenacao=baiDescricao&numpagina=" + Integer.parseInt(numPagina) + "'>Descrição</a></td><td>Alterar</td><td>Excluir</td>");
    out.println("</tr>");
    int contador = 0;
    for (java.util.Iterator iterator = listaDeBairros.iterator(); iterator.hasNext();) {
        br.com.projeto.javabean.model.BairroModel bairro = (br.com.projeto.javabean.model.BairroModel) iterator.next();
        if (contador % 2 == 0) {
            out.println("<tr style='background:white;'>");
        } else {
            out.println("<tr>");
        }
        int baiCodigo = bairro.getBaiCodigo();
        String baiDescricao = bairro.getBaiDescricao();
        out.println("<td>" + baiCodigo + "</td>");
        out.println("<td>" + baiDescricao + "</td>");
        out.println("<td><div align='center'><a href='bairro.jsp?acao=alterar&baiCodigo=" + baiCodigo + "&baiDescricao=" + baiDescricao + "'><img src='imagens/alterar.png' alt='Alterar'/></a></div></td>");
        out.println("<td><div align='center'><a href='Bairro?campoapesquisar=" + campoapesquisar + "&numpagina=" + Integer.parseInt(numPagina) + "&acao=excluir&pesquisa=" + pesquisa + "&baiCodigo=" + baiCodigo + "'><img src='imagens/excluir.png' alt='Excluir'/></a></div></td>");
        out.println("</tr>");
        contador++;
    }

    int totalRegistros = (int) request.getAttribute("sessaoqtdTotalRegistros");
    int totalPaginas = totalRegistros / limite;
    if (totalRegistros % limite != 0) {
        totalPaginas++;
    }
    out.println("<tr class='linha-especial-table'><td colspan='4'>");
    int pagAnterior;
    if (Integer.parseInt(numPagina) > 1) {
        pagAnterior = Integer.parseInt(numPagina) - 1;
        out.println("<a style='font-size:10pt;'href=Bairro?campoapesquisar=" + campoapesquisar + "&ordenacao=" + ordenacao + "&pesquisa=" + pesquisa + "&&acao=listarBairro&numpagina=" + pagAnterior + ">Anterior</a>");
    }
    for (int i = 1; i <= totalPaginas; i++) {
        if (i == Integer.parseInt(numPagina)) {
            out.println("<b>" + i + "</b>");
        } else {
            out.println("<a style='font-size:10pt;'href=Bairro?campoapesquisar=" + campoapesquisar + "&ordenacao=" + ordenacao + "&pesquisa=" + pesquisa + "&&acao=listarBairro&numpagina=" + i + ">" + i + "</a>");
        }
    }

    int proximaPag;
    if ((totalRegistros - (Integer.parseInt(numPagina) * limite)) > 0) {
        proximaPag = Integer.parseInt(numPagina) + 1;
        out.println("<a style='font-size:10pt;'href=Bairro?campoapesquisar=" + campoapesquisar + "&ordenacao=" + ordenacao + "&pesquisa=" + pesquisa + "&acao=listarBairro&numpagina=" + proximaPag + ">Próximo</a>");
    }
    String textoOrdenacao = "Descrição";
    if (ordenacao.equals("baiDescricao")) {
        textoOrdenacao = "Descrição";
    } else if (ordenacao.equals("baiCodigo")) {
        textoOrdenacao = "Código";
    }
    out.println("</br> Total de registros: " + totalRegistros + "</br> Total de Páginas: " + totalPaginas + "</br> Ordenado por: " + textoOrdenacao + "</td></tr>");
    out.println("</table>");
%>