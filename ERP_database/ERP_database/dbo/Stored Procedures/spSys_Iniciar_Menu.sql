create proc [dbo].[spSys_Iniciar_Menu]
as
delete from dbo.tb_Menu_x_Empresa_x_Usuario
delete from dbo.tb_Menu_x_Empresa
delete from dbo.tb_usuarioxempresa 
delete from dbo.tb_MenuxPerfiles
delete from dbo.tb_PerfilesPermisos
delete from dbo.tb_Perfiles where IdPerfil <>1
delete from dbo.tb_usuario where IdLogin <>'admin'