CREATE VIEW  [Fj_servindustrias].[vwct_punto_cargo_x_Af_Activo_fijo]
AS
SELECT ct_punto_cargo.IdEmpresa, ct_punto_cargo.IdPunto_cargo, ct_punto_cargo.codPunto_cargo, ct_punto_cargo.nom_punto_cargo, ct_punto_cargo.Estado, ct_punto_cargo.IdPunto_cargo_grupo, 
                  '' AS IdCentroCosto_Scc, '' AS IdCentroCosto_sub_centro_costo_Scc, ct_centro_costo.Centro_costo AS nom_centro, 
                  ct_centro_costo_sub_centro_costo.Centro_costo AS nom_subcentro, Af_Activo_fijo.IdActivoFijo
FROM     ct_punto_cargo INNER JOIN
                  Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo ON ct_punto_cargo.IdEmpresa = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_AF AND 
                  ct_punto_cargo.IdPunto_cargo = Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdPunto_cargo_PC INNER JOIN
                  Af_Activo_fijo ON Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdEmpresa_AF = Af_Activo_fijo.IdEmpresa AND Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo.IdActivoFijo_AF = Af_Activo_fijo.IdActivoFijo LEFT OUTER JOIN
                  ct_centro_costo ON Af_Activo_fijo.IdEmpresa = ct_centro_costo.IdEmpresa AND null = ct_centro_costo.IdCentroCosto LEFT OUTER JOIN
                  ct_centro_costo_sub_centro_costo ON Af_Activo_fijo.IdEmpresa = ct_centro_costo_sub_centro_costo.IdEmpresa AND null = ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  null = ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo
UNION
SELECT dbo.ct_punto_cargo.IdEmpresa, dbo.ct_punto_cargo.IdPunto_cargo, dbo.ct_punto_cargo.codPunto_cargo, dbo.ct_punto_cargo.nom_punto_cargo, dbo.ct_punto_cargo.Estado, dbo.ct_punto_cargo.IdPunto_cargo_grupo, 
                  Fj_servindustrias.ct_punto_cargo_FJ.IdCentroCosto, Fj_servindustrias.ct_punto_cargo_FJ.IdCentroCosto_sub_centro_costo, dbo.ct_centro_costo.Centro_costo AS Expr1, dbo.ct_centro_costo_sub_centro_costo.Centro_costo,
				  null as IdActivoFijo
FROM     dbo.ct_centro_costo LEFT OUTER JOIN
                  Fj_servindustrias.ct_punto_cargo_FJ ON dbo.ct_centro_costo.IdEmpresa = Fj_servindustrias.ct_punto_cargo_FJ.IdEmpresa AND 
                  dbo.ct_centro_costo.IdCentroCosto = Fj_servindustrias.ct_punto_cargo_FJ.IdCentroCosto LEFT OUTER JOIN
                  dbo.ct_centro_costo_sub_centro_costo ON Fj_servindustrias.ct_punto_cargo_FJ.IdEmpresa = dbo.ct_centro_costo_sub_centro_costo.IdEmpresa AND 
                  Fj_servindustrias.ct_punto_cargo_FJ.IdCentroCosto = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto AND 
                  Fj_servindustrias.ct_punto_cargo_FJ.IdCentroCosto_sub_centro_costo = dbo.ct_centro_costo_sub_centro_costo.IdCentroCosto_sub_centro_costo RIGHT OUTER JOIN
                  dbo.ct_punto_cargo ON Fj_servindustrias.ct_punto_cargo_FJ.IdEmpresa = dbo.ct_punto_cargo.IdEmpresa AND Fj_servindustrias.ct_punto_cargo_FJ.IdPunto_cargo = dbo.ct_punto_cargo.IdPunto_cargo
WHERE  (NOT EXISTS
                      (SELECT IdEmpresa_AF
                       FROM      Fj_servindustrias.Af_Activo_fijo_x_ct_punto_cargo AS af
                       WHERE   (dbo.ct_punto_cargo.IdEmpresa = IdEmpresa_PC) AND (dbo.ct_punto_cargo.IdPunto_cargo = IdPunto_cargo_PC)))