CREATE procedure [dbo].[spSys_CargaData_Mene_y_Menu_x_Usuario]
(@IdEmpresa int ,@IdLogin as varchar(20) )
as
begin

--select count(*) from vwSe_Perfil_x_Usuario where idempresa=1 and idlogin='admin' and HabilitadoMenu_x_Empresa=1 and HabilitadoMenuRaiz=1

/*
declare @IdEmpresa int 
declare @IdLogin varchar(20)
set @IdEmpresa =1
set @IdLogin='admin'
*/

-- select * from tb_Menu_x_Empresa
insert into tb_Menu_x_Empresa
(IdEmpresa   ,IdMenu      ,Habilitado		,NombreAsambly_x_Emp       ,NomForm_x_Emp)
select @IdEmpresa,IdMenu	,HabilitadoMenu	,''							,nom_Form
from tb_Menu
where IdMenu not in
(
	select IdMenu from tb_Menu_x_Empresa
	where IdEmpresa =@IdEmpresa
)





insert into tb_Menu_x_Empresa_x_Usuario
(IdEmpresa   ,IdLogin              ,IdMenu      ,Lectura ,Escritura ,Eliminacion)
select IdEmpresa,@IdLogin			,IdMenu		,1			,1		,1
from tb_Menu_x_Empresa
where IdEmpresa =@IdEmpresa
and IdMenu not in
(
	select IdMenu
	from tb_Menu_x_Empresa_x_Usuario
	where IdEmpresa =@IdEmpresa
	and IdLogin =@IdLogin
)


--select * from tb_Menu_x_Empresa_x_Usuario

end