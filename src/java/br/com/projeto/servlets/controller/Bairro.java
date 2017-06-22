/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.projeto.servlets.controller;

import br.com.projeto.dao.BairroDao;
import br.com.projeto.javabean.model.BairroModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gustavo Primolan
 */
public class Bairro extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        RequestDispatcher rd = null;
        String baiCodigo = request.getParameter("baiCodigo");
        String baiDescricao = request.getParameter("baiDescricao");

        BairroModel bairro = new BairroModel();
        if (baiCodigo != null) {
            bairro.setBaiCodigo(Integer.parseInt(baiCodigo));
        }
        bairro.setBaiDescricao(baiDescricao);

        BairroDao bairroDao = new BairroDao();

        //verificar qual é a ação
        String acao = request.getParameter("acao");
        if (acao == null) {
            acao = "listarBairro";
        }

        if (acao.equals("alterar")) {
            System.out.println("ALTERAR");
            bairroDao.alterarBairro(bairro);
            rd = request.getRequestDispatcher("Bairro?acao=listarBairro");
        } else if (acao.equals("excluir")) {
            System.out.println("EXCLUIR");
            bairroDao.excluirBairro(bairro);
            rd = request.getRequestDispatcher("Bairro?acao=listarBairro");
        } else if (acao.equals("listarBairro")) {
            System.out.println("LISTAR BAIRRO");
            int numPagina = 1;
            if (request.getParameter("numpagina") != null) {
                numPagina = Integer.parseInt(request.getParameter("numpagina"));
            }

            try {
                String ordenacao = request.getParameter("ordenacao");
                String pesquisa = request.getParameter("pesquisa");
                String campoapesquisar = request.getParameter("campoapesquisar");
                if (ordenacao == null) {
                    ordenacao = "baiDescricao";
                }

                if (pesquisa == null) {
                    pesquisa = "";
                }

                if (campoapesquisar == null) {
                    campoapesquisar = "baiDescricao";
                }

                List listaBairro = bairroDao.getListaBairroPaginada(numPagina, ordenacao, pesquisa, campoapesquisar);
                int qtdTotalRegistros = bairroDao.totalRegistros(pesquisa, campoapesquisar);
                request.setAttribute("sessaoListaBairroPaginada", listaBairro);
                request.setAttribute("sessaoqtdTotalRegistros", qtdTotalRegistros);
                rd = request.getRequestDispatcher("/listabairros.jsp");

            } catch (SQLException erro) {
                Logger.getLogger(Bairro.class.getName()).log(Level.SEVERE, null, erro);
            }
        } else if (acao.equals("novo")) {
            System.out.println("NOVO");
            bairroDao.novoBairro(bairro);
            rd = request.getRequestDispatcher("Bairro?acao=listarBairro");
        }
        rd.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Bairro.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Bairro.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
