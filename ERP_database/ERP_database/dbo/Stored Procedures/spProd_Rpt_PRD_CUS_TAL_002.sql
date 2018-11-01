CREATE procedure [dbo].[spProd_Rpt_PRD_CUS_TAL_002]
@IdUsuarios varchar(50),
@IdEmpresa int ,
@IdGestionProductiva Numeric(18,0),
@Nom_Pc varchar(50)
as
begin 

delete from [dbo].[tbProd_Rpt_PRD_CUS_TAL_002] where IdUsuario = @IdUsuarios and Nom_Pc = @Nom_Pc

INSERT INTO [dbo].[tbProd_Rpt_PRD_CUS_TAL_002]
select
           [IdEmpresa],[IdGestionProductiva],[IdProducto_MateriaPrima],[IdModeloProd],[Fecha],CAST([HrsTurno]AS VARCHAR(5)),CAST([Tprep]AS VARCHAR(5))
           ,CAST([Despacho]AS VARCHAR(5)),[Factor],[Num_Personas],[Consumo],[Chatarra],[Producto],[ProductoDeSegunda],[Prod_IdProducto]
           ,[Prod_Largo],[Prod_Ancho],[Prod_PsoEsp],[Prod_Espesor],[Prod_PsoUnd],[Prducc_Unidades],[Prducc_Kg],[Segunda_IdProducto]
           ,[Segunda_Unidades],[Segunda_Kg],[Chatarra_Kg],[Peso],[Kg_Desp],[Rend_Metalico],[KW],CAST([Tiempo_Preparacion]AS VARCHAR(5)),CAST([Tiempo_Produccion]AS VARCHAR(5))
           ,CAST([Tiempo_Total]AS VARCHAR(5)),CAST([Parada_Mecanica]AS VARCHAR(5)),CAST([Parada_Electrico]AS VARCHAR(5)),CAST([Parada_Logistica]AS VARCHAR(5)),CAST([Parada_Otros]AS VARCHAR(5))
           ,CAST([TotalParos]AS VARCHAR(5)),[Indicadores_TnHrs]
           ,[Indicadores_TimeParda],[Indicadores_UndsHrs],[Indicadores_Calidad],[Descripcion],[MateriaPrima],[Turno],@IdUsuarios
           ,@Nom_Pc,[Estado]
from
    [dbo].[vrprod_Rpt_GestionProductivoTechos_CusTalme] where IdEmpresa = @IdEmpresa and IdGestionProductiva = @IdGestionProductiva
end