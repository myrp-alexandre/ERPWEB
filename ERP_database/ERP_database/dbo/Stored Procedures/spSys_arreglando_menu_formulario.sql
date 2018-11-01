create proc [dbo].[spSys_arreglando_menu_formulario]
as
declare @w_formularioOld varchar(50)
declare @w_formularioNew varchar(50)
set @w_formularioOld ='frmro_Nomina_Tipo_Mant'
set @w_formularioNew ='frmRo_Nomina_Tipo_Mant'

select nom_Form,REPLACE(nom_Form,@w_formularioOld,@w_formularioNew)  from tb_Menu where nom_Form like '%' +  @w_formularioOld +'%'
select NomForm_x_Emp,REPLACE(NomForm_x_Emp,@w_formularioOld,@w_formularioNew)   from tb_Menu_x_Empresa where NomForm_x_Emp like '%' +  @w_formularioOld +'%'


update tb_Menu 
set  nom_Form=REPLACE(nom_Form,@w_formularioOld,@w_formularioNew)  
where nom_Form like '%' +  @w_formularioOld +'%'


update tb_Menu_x_Empresa 
set NomForm_x_Emp=REPLACE(NomForm_x_Emp,@w_formularioOld,@w_formularioNew)   
where NomForm_x_Emp like '%' +  @w_formularioOld +'%'

select nom_Form from tb_Menu where nom_Form like '%' +  @w_formularioOld +'%'
select NomForm_x_Emp from tb_Menu_x_Empresa where NomForm_x_Emp like '%' +  @w_formularioOld +'%'