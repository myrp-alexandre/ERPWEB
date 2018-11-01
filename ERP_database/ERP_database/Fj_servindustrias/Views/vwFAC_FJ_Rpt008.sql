CREATE VIEW [Fj_servindustrias].[vwFAC_FJ_Rpt008]
AS
SELECT      ISNULL(ROW_NUMBER() OVER(ORDER BY Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa),0) AS IdRow,  Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa, Fj_servindustrias.fa_orden_trabajo_plataforma.IdOrdenTrabajo_Pla, Fj_servindustrias.fa_orden_trabajo_plataforma.IdCliente, tb_persona.pe_nombreCompleto, 
                         Fj_servindustrias.fa_orden_trabajo_plataforma.IdVendedor, fa_Vendedor.Ve_Vendedor, Fj_servindustrias.fa_orden_trabajo_plataforma.IdTransportista, tb_transportista.Nombre, 
                         Fj_servindustrias.fa_orden_trabajo_plataforma.IdPunto_cargo, ct_punto_cargo.nom_punto_cargo, Fj_servindustrias.fa_orden_trabajo_plataforma.Fecha, Fj_servindustrias.fa_orden_trabajo_plataforma.Descripcion, 
                         Fj_servindustrias.fa_orden_trabajo_plataforma.km_salida, Fj_servindustrias.fa_orden_trabajo_plataforma.km_llegada, det.Valor
FROM            Fj_servindustrias.fa_orden_trabajo_plataforma INNER JOIN
                         ct_punto_cargo ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = ct_punto_cargo.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdPunto_cargo = ct_punto_cargo.IdPunto_cargo INNER JOIN
                         tb_transportista ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = tb_transportista.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdTransportista = tb_transportista.IdTransportista INNER JOIN
                         fa_cliente ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = fa_cliente.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdCliente = fa_cliente.IdCliente INNER JOIN
                         fa_Vendedor ON Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = fa_Vendedor.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdVendedor = fa_Vendedor.IdVendedor AND 
                         Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = fa_Vendedor.IdEmpresa AND Fj_servindustrias.fa_orden_trabajo_plataforma.IdVendedor = fa_Vendedor.IdVendedor INNER JOIN
                         tb_persona ON fa_cliente.IdPersona = tb_persona.IdPersona
						 inner join(
							SELECT        IdEmpresa, IdOrdenTrabajo_Pla, SUM(Valor) AS Valor
							FROM            Fj_servindustrias.fa_orden_trabajo_plataforma_det
							GROUP BY IdEmpresa, IdOrdenTrabajo_Pla
						 ) det on Fj_servindustrias.fa_orden_trabajo_plataforma.IdEmpresa = det.IdEmpresa and Fj_servindustrias.fa_orden_trabajo_plataforma.IdOrdenTrabajo_Pla = det.IdOrdenTrabajo_Pla
WHERE Fj_servindustrias.fa_orden_trabajo_plataforma.Estado = 'A'