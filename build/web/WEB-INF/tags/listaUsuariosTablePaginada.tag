<%@tag body-content="empty"%>
<%
    int limite = 10;
    String numPagina = request.getParameter("numpagina");
    if (numPagina == null) {
        numPagina = "1";
    }

    //int offset = (Integer.parseInt(numPagina) * limite) - limite;
    //out.println("limite = " + limite);
    //out.println("numPagina = " + numPagina);
    //out.println("offset = " + offset);
    //java.sql.Connection conexao = null;
    // a linha abaixo "chama" o driver
    //String driver = "com.mysql.jdbc.Driver";
    // Armazenando informações referente ao banco
    //String url = "jdbc:mysql://localhost:3306/dbprojeto";
    //String user = "root";
    //String password = "";
    //Connection connection = null;
    // Estabelecendo a conexão com o banco
    //try {
    //    Class.forName(driver);
    //    connection = DriverManager.getConnection(url, user, password);
    //} catch (Exception e) {
    //}
    //String sql = "select * from usuarios limit 6 offset " + offset;
    //PreparedStatement ps = connection.prepareStatement(sql);
    //ResultSet resultSet = ps.executeQuery();
    java.util.List listaDeUsuarios = (java.util.List) request.getAttribute("sessaoListaUsuariosPaginada");

    String ordenacao = request.getParameter("ordenacao");
    if (ordenacao == null) {
        ordenacao = "nomecompleto";
    }

    String pesquisa = request.getParameter("pesquisa");
    if (pesquisa == null) {
        pesquisa = "";
    }

    String campoapesquisar = request.getParameter("campoapesquisar");
    if (campoapesquisar == null) {
        campoapesquisar = "nomecompleto";
    }

    out.println("<table border='1'>");
    out.println("<form action='Usuario' method='get'>");
    out.println("<tr class='linha-especial-table'><td colspan='6'>"
            + "<select name='campoapesquisar'>");
    if (campoapesquisar.equals("nomecompleto")) {
        out.println("<option selected='selected' value='nomecompleto'>Nome Completo</option>");
    } else {
        out.println("<option value='nomecompleto'>Nome Completo</option>");
    }
    if (campoapesquisar.equals("usuario")) {
        out.println("<option selected='selected' value='usuario'>Usuário</option>");
    } else {
        out.println("<option value='usuario'>Usuário</option>");
    }
    if (campoapesquisar.equals("nivel")) {
        out.println("<option selected='selected' value='nivel'>Nível</option>");
    } else {
        out.println("<option value='nivel'>Nível</option>");
    }
    out.println("</select>");
    out.println("</br>");
    out.println("<input placeholder='Localizar' type='text' name='pesquisa'/></br>");
    out.println("<input type='hidden' name='acao' value='listarUsuario'/>");
    out.println("<input type='image' src='imagens/localizar.png' width='40px' height='40px'/></td></tr>");
    out.println("</form>");
    out.println("<tr><td colspan='6'><a href='usuario.jsp?acao=novo'><img src='imagens/novo.png'/></a></td></tr>");
    out.println("<tr class='linha-especial-table'>");
    out.println("<td><a href='Usuario?campoapesquisar=" + campoapesquisar + "&pesquisa=" + pesquisa + "&acao=listarUsuario&ordenacao=usuario&numpagina=" + Integer.parseInt(numPagina) + "'>Usuário</a></td><td>Senha</td><td><a href='Usuario?campoapesquisar=" + campoapesquisar + "&pesquisa=" + pesquisa + "&listarUsuario&ordenacao=nivel&numpagina=" + Integer.parseInt(numPagina) + "'>Nível</a></td><td><a href='Usuario?campoapesquisar=" + campoapesquisar + "&pesquisa=" + pesquisa + "&listarUsuario&ordenacao=nomecompleto&numpagina=" + Integer.parseInt(numPagina) + "'>Nome Completo</a></td><td>Alterar</td><td>Excluir</td>");
    out.println("</tr>");
    int contador = 0;
    for (java.util.Iterator iterator = listaDeUsuarios.iterator(); iterator.hasNext();) {
        br.com.projeto.javabean.model.UsuariosModel usuarios = (br.com.projeto.javabean.model.UsuariosModel) iterator.next();
        // out.println("Usuário:" + resultSet.getString("usuario") + ", senha:" + resultSet.getString("senha") + "  Nivel:" + resultSet.getString("nivel") + "</br>");
        if (contador % 2 == 0) {
            out.println("<tr style='background:white;'>");
        } else {
            out.println("<tr>");
        }
        String usuario = usuarios.getUsuario();
        String senha = usuarios.getSenha();
        String nivel = String.valueOf(usuarios.getNivel());
        String nomeCompleto = usuarios.getNomeCompleto();
        out.println("<td>" + usuario + "</td>");
        out.println("<td>" + senha + "</td>");
        out.println("<td>" + nivel + "</td>");
        out.println("<td>" + nomeCompleto + "</td>");
        out.println("<td><div align='center'><a href='usuario.jsp?acao=alterar&usuario=" + usuario + "&senha=" + senha + "&nivel=" + nivel + "&nomecompleto=" + nomeCompleto + "'><img src='imagens/alterar.png' alt='Alterar'/></a></div></td>");
        out.println("<td><div align='center'><a href='Usuario?campoapesquisar=" + campoapesquisar + "&numpagina=" + Integer.parseInt(numPagina) + "&acao=excluir&pesquisa=" + pesquisa + "&usuario=" + usuario + "'><img src='imagens/excluir.png' alt='Excluir'/></a></div></td>");
        out.println("</tr>");
        contador++;
    }

    //out.println("</br><a href=listausuariospaginada.jsp?numpagina=1>1</a>");
    //out.println("</br><a href=listausuariospaginada.jsp?numpagina=2>2</a>");
    //String sqlConta = "select count(*) as contaRegistros from usuarios";
    //PreparedStatement psConta = connection.prepareStatement(sqlConta);
    //ResultSet resultSetConta = psConta.executeQuery();
    //resultSetConta.next();
    //int totalRegistros = Integer.parseInt(resultSetConta.getString("contaRegistros"));
    int totalRegistros = (int) request.getAttribute("sessaoqtdTotalRegistros");
    int totalPaginas = totalRegistros / limite;
    if (totalRegistros % limite != 0) {
        totalPaginas++;
    }
    //out.println("<tr class='linha-especial-table'><td colspan='6'>Quantidade de registros:" + totalRegistros);
    //out.println("</br>Total de páginas a serem mostradas: " + totalPaginas);
    //out.println("</td></tr>");
    out.println("<tr class='linha-especial-table'><td colspan='6'>");
    int pagAnterior;
    if (Integer.parseInt(numPagina) > 1) {
        pagAnterior = Integer.parseInt(numPagina) - 1;
        out.println("<a style='font-size:10pt;'href=Usuario?campoapesquisar=" + campoapesquisar + "&ordenacao=" + ordenacao + "&pesquisa=" + pesquisa + "&&acao=listarUsuario&numpagina=" + pagAnterior + ">Anterior</a>");
    }
    for (int i = 1; i <= totalPaginas; i++) {
        if (i == Integer.parseInt(numPagina)) {
            out.println("<b>" + i + "</b>");
        } else {
            out.println("<a style='font-size:10pt;'href=Usuario?campoapesquisar=" + campoapesquisar + "&ordenacao=" + ordenacao + "&pesquisa=" + pesquisa + "&&acao=listarUsuario&numpagina=" + i + ">" + i + "</a>");
        }
    }

    int proximaPag;
    if ((totalRegistros - (Integer.parseInt(numPagina) * limite)) > 0) {
        proximaPag = Integer.parseInt(numPagina) + 1;
        out.println("<a style='font-size:10pt;'href=Usuario?campoapesquisar=" + campoapesquisar + "&ordenacao=" + ordenacao + "&pesquisa=" + pesquisa + "&acao=listarUsuario&numpagina=" + proximaPag + ">Próximo</a>");
    }
    String textoOrdenacao = "Nome Completo";
    if (ordenacao.equals("nomecompleto")) {
        textoOrdenacao = "Nome Completo";
    } else if (ordenacao.equals("nivel")) {
        textoOrdenacao = "Nível";
    } else if (ordenacao.equals("usuario")) {
        textoOrdenacao = "Usuário";
    }
    out.println("</br> Total de registros: " + totalRegistros + "</br> Total de Páginas: " + totalPaginas + "</br> Ordenado por: " + textoOrdenacao + "</td></tr>");
    out.println("</table>");
%>