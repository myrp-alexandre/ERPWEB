--exec [Naturisa].[spCXP_NATU_Rpt004] 1,1,99999,'01/01/2015','31/12/2016',7,7,'rguerra'
CREATE procedure [Naturisa].[spCXP_NATU_Rpt004]

 @IdEmpresa int,
 @IdProveedorIni numeric(18,0),
 @IdProveedorFin numeric(18,0),
 @fechaIni datetime,
 @fechaFin datetime,
 @IdClaseProveedorIni int,
 @IdClaseProveedorFin int,
 @IdUsuario varchar(20)
 as
 DELETE [Naturisa].[cp_CXP_NATU_Rpt004] WHERE IdEmpresa = @IdEmpresa and IdUsuario = @IdUsuario

 INSERT INTO [Naturisa].[cp_CXP_NATU_Rpt004]
           ([IdEmpresa]
           ,[IdProveedor]
           ,[IdUsuario]
           ,[nom_proveedor]
           ,[Saldo_inicial]
           ,[Debitos]
           ,[Creditos]
           ,[Saldo]
           ,[descripcion_clas_prove]
           ,[IdClaseProveedor])
SELECT        IdEmpresa, IdProveedor, @IdUsuario,nom_proveedor,SUM(Deb) - SUM(Cred)  as Saldo_inicial, 0,0,0,descripcion_clas_prove, IdClaseProveedor
FROM            (SELECT        IdEmpresa, IdProveedor, nom_proveedor, SUM(Valor_debe) AS Deb, SUM(Valor_Haber) AS Cred, IdClaseProveedor, 
                                                    descripcion_clas_prove
                          FROM            dbo.vwCXP_Rpt001
						  where co_fechaOg < @fechaIni and IdEmpresa=@IdEmpresa AND IdClaseProveedor between @IdClaseProveedorIni and @IdClaseProveedorFin
							and IdProveedor between @IdProveedorIni and @IdProveedorFin
                          GROUP BY IdEmpresa, IdProveedor, nom_proveedor, IdClaseProveedor, descripcion_clas_prove) AS a
WHERE A.IdEmpresa = @IdEmpresa 
GROUP BY IdEmpresa, IdProveedor, nom_proveedor, IdClaseProveedor, descripcion_clas_prove

 INSERT INTO [Naturisa].[cp_CXP_NATU_Rpt004]
           ([IdEmpresa]
           ,[IdProveedor]
           ,[IdUsuario]
           ,[nom_proveedor]
           ,[Saldo_inicial]
           ,[Debitos]
           ,[Creditos]
           ,[Saldo]
           ,[descripcion_clas_prove]
           ,[IdClaseProveedor])
SELECT        IdEmpresa, IdProveedor, @IdUsuario,nom_proveedor, 0  as Saldo,0,0,0,descripcion_clas_prove,IdClaseProveedor
FROM            (SELECT        IdEmpresa, IdProveedor, nom_proveedor, SUM(Valor_debe) AS Deb, SUM(Valor_Haber) AS Cred, IdClaseProveedor, 
                                                    descripcion_clas_prove
                          FROM            dbo.vwCXP_Rpt001
						  where co_fechaOg <= @fechaFin and IdEmpresa=@IdEmpresa AND IdClaseProveedor between @IdClaseProveedorIni and @IdClaseProveedorFin
						and IdProveedor between @IdProveedorIni and @IdProveedorFin
                          GROUP BY IdEmpresa, IdProveedor, nom_proveedor, IdClaseProveedor, descripcion_clas_prove) AS a
WHERE A.IdEmpresa = @IdEmpresa AND not exists(
select cxp.IdEmpresa
from [Naturisa].[cp_CXP_NATU_Rpt004] CXP
WHERE CXP.IdEmpresa = A.IdEmpresa
AND CXP.IdProveedor = A.IdProveedor
AND CXP.IdUsuario = @IdUsuario
)
GROUP BY IdEmpresa, IdProveedor, nom_proveedor, IdClaseProveedor, descripcion_clas_prove

update Naturisa.cp_CXP_NATU_Rpt004
SET Debitos = A.Deb,
Creditos = a.Cred
FROM(
select IdEmpresa, IdProveedor, isnull(sum(Valor_debe),0)Deb, isnull(sum(Valor_Haber),0)Cred
from vwCXP_Rpt001
WHERE IdEmpresa = @IdEmpresa AND co_fechaOg BETWEEN @fechaIni AND @fechaFin AND IdClaseProveedor between @IdClaseProveedorIni and @IdClaseProveedorFin
and IdProveedor between @IdProveedorIni and @IdProveedorFin
group by IdEmpresa, IdProveedor, IdClaseProveedor
) A WHERE Naturisa.cp_CXP_NATU_Rpt004.IdEmpresa = A.IdEmpresa
AND Naturisa.cp_CXP_NATU_Rpt004.IdProveedor = A.IdProveedor
AND Naturisa.cp_CXP_NATU_Rpt004.IdUsuario = @IdUsuario

UPDATE Naturisa.cp_CXP_NATU_Rpt004 SET Saldo = Saldo_inicial + Debitos - Creditos

select isnull(ROW_NUMBER() OVER(ORDER BY [IdEmpresa]),0) AS IdRow, [IdEmpresa]           ,[IdProveedor]           ,[IdUsuario]           ,[nom_proveedor]           ,[Saldo_inicial]
           ,[Debitos]           ,[Creditos]           ,[Saldo]           ,[descripcion_clas_prove]           ,[IdClaseProveedor]
from Naturisa.cp_CXP_NATU_Rpt004
where IdEmpresa = @IdEmpresa
and IdUsuario = @IdUsuario