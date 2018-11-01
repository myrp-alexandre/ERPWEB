
CREATE PROCEDURE [dbo].[spSys_CargarMenuPrimeraVez_InicializacionMenu]
AS
BEGIN
	insert into tb_Menu_x_Empresa ( IdEmpresa , IdMenu , Habilitado , NombreAsambly_x_Emp, NomForm_x_Emp)
	select								1	  , IdMenu,1			,nom_Asembly		 ,nom_Form
	from tb_Menu where IdMenu in(28,29,30,32,115,116)
	INSERT INTO tb_Menu_x_Empresa_x_Usuario  ( IdEmpresa , IdLogin , IdMenu,Lectura,Escritura,Eliminacion)
	SELECT										IdEmpresa, 'admin' , IdMenu,1      ,		1,1 
	FROM tb_Menu_x_Empresa 
	
	select * from tb_Menu_x_Empresa
	select * from tb_Menu_x_Empresa_x_Usuario


END