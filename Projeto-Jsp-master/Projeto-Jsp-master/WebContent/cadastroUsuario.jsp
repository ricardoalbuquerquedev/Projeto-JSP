<%@page import="beans.BeanCursoJsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="resources/css/cadastro.css" rel="stylesheet">

<!-- Adicionando JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>

<title>Cadastro de Usu?rio</title>
</head>
<body>
	<a href="acessoliberado.jsp"><img alt="Inicio" title="Inicio"
		src="resources/img/home.png" width="30" height="30"></a>
	<a href="index.jsp"><img alt="Sair" title="Sair"
		src="resources/img/exit.png" width="30" height="30"></a>
	<h2 class="center">Cadastro de Usuario</h2>
	<h3 class="center" style="color: orange">${msg}</h3>
	<form action="salvarUsuario" method="post" id="formUser"
		onsubmit="return validarCampos() ? true:false;"
		enctype="multipart/form-data">
		<ul class="form-style-1">
			<li>
				<table>
					<tr>
						<td>Codigo:</td>
						<td><input type="text" readonly="readonly" id="id" name="id"
							value="${user.id}"></td>
						<td>Ativo:</td>
						<td><input type="checkbox" id="ativo" name="ativo"
							<%if (request.getAttribute("user") != null) {
				BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
				if (user.isAtivo()) {
					out.print(" ");
					out.print("checked=\"checked\"");
					out.print(" ");
				}
			}%>></td>
					</tr>
					<tr>
						<td>Login:</td>
						<td><input type="text" id="login" name="login"
							value="${user.login}" placeholder="Informe o login"
							maxlength="20"></td>

						<td>Senha:</td>
						<td><input type="password" id="senha" name="senha"
							value="${user.senha}" placeholder="Informe a senha"
							maxlength="10"></td>
					</tr>
					<tr>
						<td>Nome:</td>
						<td><input type="text" id="nome" name="nome"
							value="${user.nome}" placeholder="Informe o nome" maxlength="50"></td>

						<td>Telefone:</td>
						<td><input type="text" id="telefone" name="telefone"
							value="${user.telefone}" placeholder="Informe o telefone"
							maxlength="14"></td>
					</tr>
					<tr>
						<td>Cep:</td>
						<td><input type="text" id="cep" name="cep"
							value="${user.cep}" placeholder="Informe o cep" maxlength="9"></td>

						<td>Ibge:</td>
						<td><input type="text" id="ibge" name="ibge"
							value="${user.ibge}" maxlength="10"></td>
					</tr>
					<tr>
						<td>Rua:</td>
						<td><input type="text" id="rua" name="rua"
							value="${user.rua}" maxlength="100"></td>

						<td>Bairro:</td>
						<td><input type="text" id="bairro" name="bairro"
							value="${user.bairro}" maxlength="50"></td>
					</tr>
					<tr>
						<td>Cidade:</td>
						<td><input type="text" id="cidade" name="cidade"
							value="${user.cidade}" maxlength="50"></td>

						<td>Estado:</td>
						<td><input type="text" id="estado" name="estado"
							value="${user.estado}" maxlength="2"></td>
					</tr>
					
						<tr>
					<td>Perfil: </td>
					<td>
						<select id="perfil" name="perfil" style="width: 185px; height: 30px;">
						<option value="nao_informado">[--SELECIONE--]</option>
						<option value="administrador" 
						
						<%
						if (request.getAttribute("user") != null) {
						
						BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
						if (user.getPerfil().equalsIgnoreCase("administrador")) {
							out.print(" ");
							out.print("selected=\"selected\"");
							out.print(" ");
							}
						}
						%>
						
						>Administrador</option>
						<option value="secretario"
						
						<%
						if (request.getAttribute("user") != null) {
						
						BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
						if (user.getPerfil().equalsIgnoreCase("secretario")) {
							out.print(" ");
							out.print("selected=\"selected\"");
							out.print(" ");
							}
						}
						%>
						
						>Secretario(a)</option>
						<option value="gerente"
						
						<%
						if (request.getAttribute("user") != null) {
						
						BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
						if (user.getPerfil().equalsIgnoreCase("gerente")) {
							out.print(" ");
							out.print("selected=\"selected\"");
							out.print(" ");
							}
						}
						%>
						
						>Gerente</option>
						<option value="funcionario"
						
						<%
						if (request.getAttribute("user") != null) {
						
						BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
						if (user.getPerfil().equalsIgnoreCase("funcionario")) {
							out.print(" ");
							out.print("selected=\"selected\"");
							out.print(" ");
							}
						}
						%>
						
						>Funcion?rio</option>
						</select>
					</td>

					<td>Sexo:</td>
					<td><input type="radio" name="sexo"
						
					<%
					if (request.getAttribute("user") != null) {
						
						BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
						if (user.getSexo().equalsIgnoreCase("masculino")) {
						out.print(" ");
						out.print("checked=\"checked\"");
						out.print(" ");
						}
					}
					%>
						
					value="masculino">Masculino</input> 
							
					<input type="radio" name="sexo" 
					<%
					if (request.getAttribute("user") != null) {
						
						BeanCursoJsp user = (BeanCursoJsp) request.getAttribute("user");
						if (user.getSexo().equalsIgnoreCase("feminino")) {
							out.print(" ");
							out.print("checked=\"checked\"");
							out.print(" ");
							}
					}
					%>
						
					value="feminino">Feminino</input></td>
					</tr>
					
					<tr>
						<td>Foto</td>
						<td><input type="file" name="foto"> <input
							type="text" style="display: none;" name="fotoTemp"
							readonly="readonly" value="${user.fotoBase64}"> <input
							type="text" style="display: none;" name="contentTypeTemp"
							readonly="readonly" value="${user.contentType}"></td>
					</tr>

					<tr>
						<td>Curr?culo</td>
						<td><input type="file" name="curriculo"> <input
							type="text" style="display: none;" name="curriculoTemp"
							readonly="readonly" value="${user.curriculoBase64}"> <input
							type="text" style="display: none;"
							name="curriculoContentTypeTemp" readonly="readonly"
							value="${user.contentTypeCurriculo}"></td>
					</tr>					

					<tr>
						<td></td>
						<td><input type="submit" value="Salvar"
							style="margin-right: 5px"><input type="submit"
							value="Cancelar"
							onclick="document.getElementById('formUser').action = 'salvarUsuario?acao=reset'"></td>
					</tr>
				</table>
			</li>
		</ul>
	</form>
	
	<form method="post" action="servletPesquisa">
		<ul class="form-style-1">
			<li>
				<table>
					<tr>
						<td>Descri??o</td>
						<td><input type="text" id="descricaoconsulta" name="descricaoconsulta"></td>
						<td><input type="submit" value="Pesquisar"></td>
					</tr>
				</table>
			<li>
		</ul>
	</form>
	
	<div class="container">
		<table class="responsive-table">
			<caption>Usuarios Cadastrados</caption>
			<tbody>
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Foto</th>
					<th scope="col">Curr?culo</th>
					<th scope="col">Nome</th>
					<th scope="col">Telefone</th>
					<th scope="col">Editar</th>
					<th scope="col">Excluir</th>
				</tr>

				<c:forEach items="${usuarios}" var="user">
					<tr>
						<td><c:out value="${user.id}" /></td>

						<c:if test="${user.fotoBase64Miniatura != null}">
							<td><a
								href="salvarUsuario?acao=download&tipo=imagem&user=${user.id}"><img
									src='<c:out value="${user.fotoBase64Miniatura}"/>'
									alt="Imagem User" title="Imagem User" width="32px"
									height="32px" /> </a></td>
						</c:if>
						<c:if test="${user.fotoBase64Miniatura == null}">
							<td><img alt="Imagem User" src="resources/img/userEmpty.png"
								width="32px" height="32px" onclick="alert('N?o possui imagem')">
							</td>
						</c:if>
						<c:if test="${user.curriculoBase64.isEmpty() == false}">
							<td><a
								href="salvarUsuario?acao=download&tipo=curriculo&user=${user.id}"><img
									alt="Curriculo" src="resources/img/imagemPdf.png" width="32px"
									height="32px"> </a></td>
						</c:if>
						<c:if test="${user.curriculoBase64.isEmpty() == true}">
							<td><img alt="Curriculo" src="resources/img/pdfEmpty.png"
								width="32px" height="32px"
								onclick="alert('N?o possui curr?culo')"></td>
						</c:if>

						<td><c:out value="${user.nome}" /></td>
						<td><a href="salvarTelefone?acao=addFone&user=${user.id}"><img
								src="resources/img/telefone.png" alt="Telefones"
								title="Telefones" width="32px" height="32px" /></a></td>
						<td><a href="salvarUsuario?acao=editar&user=${user.id}"><img
								src="resources/img/editar.png" alt="Editar" title="Editar"
								width="32px" height="32px" /></a></td>
						<td><a href="salvarUsuario?acao=delete&user=${user.id}"
							onclick="return confirm('Deseja confirmar a exclus?o?');"><img
								src="resources/img/excluir.png" alt="Excluir" title="Excluir"
								width="32px" height="32px" /></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<script type="text/javascript">
		function validarCampos() {
			if (document.getElementById("login").value == '') {
				alert('Informe o Login');
				return false;
			} else if (document.getElementById("nome").value == '') {
				alert('Informe o Nome');
				return false;
			} else if (document.getElementById("senha").value == '') {
				alert('Informe a Senha');
				return false;
			} else if (document.getElementById("telefone").value == '') {
				alert('Informe o Telefone');
				return false;
			}

			return true;
		}
		
		<!-- Adicionando Javascript Cep-->
			$(document).ready(
					function() {

						function limpa_formul?rio_cep() {
							// Limpa valores do formul?rio de cep.
							$("#rua").val("");
							$("#bairro").val("");
							$("#cidade").val("");
							$("#estado").val("");
							$("#ibge").val("");
						}

						//Quando o campo cep perde o foco.
						$("#cep").blur(
								function() {

									//Nova vari?vel "cep" somente com d?gitos.
									var cep = $(this).val().replace(/\D/g, '');

									//Verifica se campo cep possui valor informado.
									if (cep != "") {

										//Express?o regular para validar o CEP.
										var validacep = /^[0-9]{8}$/;

										//Valida o formato do CEP.
										if (validacep.test(cep)) {

											//Preenche os campos com "..." enquanto consulta webservice.
											$("#rua").val("...");
											$("#bairro").val("...");
											$("#cidade").val("...");
											$("#estado").val("...");
											$("#ibge").val("...");

											//Consulta o webservice viacep.com.br/
											$.getJSON("https://viacep.com.br/ws/" + cep
													+ "/json/?callback=?", function(
													dados) {

												if (!("erro" in dados)) {
													//Atualiza os campos com os valores da consulta.
													$("#rua").val(dados.logradouro);
													$("#bairro").val(dados.bairro);
													$("#cidade").val(dados.localidade);
													$("#estado").val(dados.uf);
													$("#ibge").val(dados.ibge);
												} //end if.
												else {
													//CEP pesquisado n?o foi encontrado.
													limpa_formul?rio_cep();
													alert("CEP n?o encontrado.");
												}
											});
										} //end if.
										else {
											//cep ? inv?lido.
											limpa_formul?rio_cep();
											alert("Formato de CEP inv?lido.");
										}
									} //end if.
									else {
										//cep sem valor, limpa formul?rio.
										limpa_formul?rio_cep();
									}
								});
					});
		</script>
</body>
</html>