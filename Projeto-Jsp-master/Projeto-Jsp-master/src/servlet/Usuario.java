package servlet;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.codec.binary.Base64;

import beans.BeanCursoJsp;
import dao.DaoUsuario;

@WebServlet("/salvarUsuario")
@MultipartConfig
public class Usuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DaoUsuario daoUsuario = new DaoUsuario();

	public Usuario() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String acao = request.getParameter("acao");
			String user = request.getParameter("user");

			if (acao != null) {
				if (acao.equalsIgnoreCase("delete")) {
					daoUsuario.delete(user);

					RequestDispatcher dispatcher = request.getRequestDispatcher("/cadastroUsuario.jsp");
					request.setAttribute("usuarios", daoUsuario.listarUsuarios());
					dispatcher.forward(request, response);

				} else if (acao.equalsIgnoreCase("editar")) {
					BeanCursoJsp beanCursoJsp = daoUsuario.consultar(user);

					RequestDispatcher dispatcher = request.getRequestDispatcher("/cadastroUsuario.jsp");
					request.setAttribute("user", beanCursoJsp);
					dispatcher.forward(request, response);

				} else if (acao.equalsIgnoreCase("listartodos")) {
					RequestDispatcher dispatcher = request.getRequestDispatcher("/cadastroUsuario.jsp");
					request.setAttribute("usuarios", daoUsuario.listarUsuarios());
					dispatcher.forward(request, response);
				} else if (acao.equalsIgnoreCase("download")) {
					BeanCursoJsp usuario = daoUsuario.consultar(user);
					if (usuario != null) {
						String contentType = "";
						byte[] fileBytes = null;
						String tipo = request.getParameter("tipo");

						if (tipo.equalsIgnoreCase("imagem")) {
							contentType = usuario.getContentType();
							fileBytes = new Base64().decodeBase64(usuario.getFotoBase64());
						} else if (tipo.equalsIgnoreCase("curriculo")) {
							contentType = usuario.getContentTypeCurriculo();
							fileBytes = new Base64().decodeBase64(usuario.getCurriculoBase64());
						}

						response.setHeader("Content-Disposition",
								"attachment;filename=arquivo." + contentType.split("\\/")[1]);

						/* Coloca os bytes em um objeto de entrada para processar */
						InputStream is = new ByteArrayInputStream(fileBytes);

						/* inicio da resposta para o navegador */
						int read = 0;
						byte[] bytes = new byte[1024];
						OutputStream os = response.getOutputStream();

						while ((read = is.read(bytes)) != -1) {
							os.write(bytes, 0, read);
						}

						os.flush();
						os.close();

					}
				}
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("usuarios", daoUsuario.listarUsuarios());
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String acao = request.getParameter("acao");

		if (acao != null && acao.equalsIgnoreCase("reset")) {
			try {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("usuarios", daoUsuario.listarUsuarios());
				dispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {

			String id = request.getParameter("id");
			String login = request.getParameter("login");
			String senha = request.getParameter("senha");
			String nome = request.getParameter("nome");
			String telefone = request.getParameter("telefone");

			String cep = request.getParameter("cep");
			String rua = request.getParameter("rua");
			String bairro = request.getParameter("bairro");
			String cidade = request.getParameter("cidade");
			String estado = request.getParameter("estado");
			String ibge = request.getParameter("ibge");
			String sexo = request.getParameter("sexo");
			String perfil = request.getParameter("perfil");
			
			BeanCursoJsp beanCursoJsp = new BeanCursoJsp();

			beanCursoJsp.setId(!id.isEmpty() ? Long.parseLong(id) : null);
			beanCursoJsp.setLogin(login);
			beanCursoJsp.setSenha(senha);
			beanCursoJsp.setNome(nome);
			beanCursoJsp.setTelefone(telefone);

			beanCursoJsp.setCep(cep);
			beanCursoJsp.setRua(rua);
			beanCursoJsp.setBairro(bairro);
			beanCursoJsp.setCidade(cidade);
			beanCursoJsp.setEstado(estado);
			beanCursoJsp.setIbge(ibge);
			beanCursoJsp.setSexo(sexo);
			beanCursoJsp.setPerfil(perfil);
			
			if(request.getParameter("ativo") != null && request.getParameter("ativo").equalsIgnoreCase("on")) {
				beanCursoJsp.setAtivo(true);
			}else {
				beanCursoJsp.setAtivo(false);
			}
			
			// Inicio File Upload de imagens e pdf
			try {

				if (ServletFileUpload.isMultipartContent(request)) {
					Part imagemFoto = request.getPart("foto");

					if (imagemFoto != null && imagemFoto.getInputStream().available() > 0) {

						String fotoBase64 = new Base64()
								.encodeBase64String(converteStremParabyte(imagemFoto.getInputStream()));

						beanCursoJsp.setFotoBase64(fotoBase64);
						beanCursoJsp.setContentType(imagemFoto.getContentType());
						/* Inicio miniatura da imagem */

						/* Transforma em um BufferedImage */
						byte[] imageByteDecode = new Base64().decodeBase64(fotoBase64);
						BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(imageByteDecode));
						/* Pega o tipo da imagem */

						int type = bufferedImage.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : bufferedImage.getType();
						/* Cria imagem em miniatura */

						BufferedImage resizedImage = new BufferedImage(100, 100, type);
						Graphics2D g = resizedImage.createGraphics();
						g.drawImage(bufferedImage, 0, 0, 100, 100, null);
						g.dispose();
						/* Escrever imagem novamente */

						ByteArrayOutputStream baos = new ByteArrayOutputStream();
						ImageIO.write(resizedImage, "png", baos);

						String miniaturaBase64 = "data:image/png;base64,"
								+ DatatypeConverter.printBase64Binary(baos.toByteArray());

						beanCursoJsp.setFotoBase64Miniatura(miniaturaBase64);
						/* Fim miniatura da imagem */

					} else {
						beanCursoJsp.setFotoBase64(request.getParameter("fotoTemp"));
						beanCursoJsp.setContentType(request.getParameter("contentTypeTemp"));
					}

					// Processa PDF
					Part curriculoPdf = request.getPart("curriculo");

					if (curriculoPdf != null && curriculoPdf.getInputStream().available() > 0) {
						String curriculoBase64 = new Base64()
								.encodeBase64String(converteStremParabyte(curriculoPdf.getInputStream()));

						beanCursoJsp.setCurriculoBase64(curriculoBase64);
						beanCursoJsp.setContentTypeCurriculo(curriculoPdf.getContentType());
					} else {
						beanCursoJsp.setCurriculoBase64(request.getParameter("curriculoTemp"));
						beanCursoJsp.setContentTypeCurriculo(request.getParameter("curriculoContentTypeTemp"));
					}
				}

				// Fim File Upload

				boolean podeInserir = true;
				String msg = null;

				if (login == null || login.isEmpty()) {
					msg = "\nLogin ? um campo obrigat?rio";
					podeInserir = false;
				} else if (nome == null || nome.isEmpty()) {
					msg = "\nNome ? um campo obrigat?rio";
					podeInserir = false;
				} else if (senha == null || senha.isEmpty()) {
					msg = "\nSenha ? um campo obrigat?rio";
					podeInserir = false;
				} else if (telefone == null || telefone.isEmpty()) {
					msg = "\nTelefone ? um campo obrigat?rio";
					podeInserir = false;
				} else if (id == null || id.isEmpty() && !daoUsuario.validarLogin(login)) {
					msg = "\nUsu?rio j? existe com o mesmo login";
					podeInserir = false;
				}

				else if (id == null || id.isEmpty() && !daoUsuario.validarSenha(senha)) {
					msg = "\nUsu?rio j? existe com o mesma senha";
					podeInserir = false;
				}

				if (msg != null) {
					request.setAttribute("msg", msg);
				}

				if (id == null || id.isEmpty() && daoUsuario.validarLogin(login) && podeInserir) {
					daoUsuario.salvar(beanCursoJsp);
				}

				else if (id != null && !id.isEmpty()) {
					if (!daoUsuario.validarLoginUpdate(login, id)) {
						request.setAttribute("msg", "Usu?rio j? existe com o mesmo login");
						podeInserir = false;
					} else if (!daoUsuario.validarSenhaUpdate(senha, id)) {
						request.setAttribute("msg", "Usu?rio j? existe com o mesma senha");
						podeInserir = false;
					} else {
						daoUsuario.atualizar(beanCursoJsp);
					}
				}

				if (!podeInserir) {
					request.setAttribute("user", beanCursoJsp);
				}

				RequestDispatcher dispatcher = request.getRequestDispatcher("/cadastroUsuario.jsp");
				request.setAttribute("usuarios", daoUsuario.listarUsuarios());
				request.setAttribute("msg", "Salvo com sucesso!");
				dispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/* Converte a entrada de fluxo de dados da imagem para byte[] */
	private byte[] converteStremParabyte(InputStream imagem) throws Exception {

		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		int reads = imagem.read();
		while (reads != -1) {
			baos.write(reads);
			reads = imagem.read();
		}

		return baos.toByteArray();

	}

}
