
CREATE VIEW [dbo].[vwcp_orden_pago_tipo_x_empresa]
AS
SELECT        A.IdTipo_op, A.Descripcion, A.Estado, A.GeneraDiario, B.IdEmpresa, B.IdCtaCble, B.IdCentroCosto, B.IdTipoCbte_OP, B.IdTipoCbte_OP_anulacion, 
                         B.IdEstadoAprobacion, B.IdCtaCble_Credito,B.Dispara_Alerta
FROM            cp_orden_pago_tipo AS A INNER JOIN
                         cp_orden_pago_tipo_x_empresa AS B ON A.IdTipo_op = B.IdTipo_op
UNION
SELECT        A.IdTipo_op, A.Descripcion, A.Estado, A.GeneraDiario, B.IdEmpresa, NULL AS IdCtaCble, NULL AS IdCentroCosto, NULL AS IdTipoCbte_OP, NULL 
                         AS IdTipoCbte_OP_anulacion, NULL AS IdEstadoAprobacion, NULL IdCtaCble_Credito,null Dispara_Alerta
FROM            cp_orden_pago_tipo AS A CROSS JOIN
                         tb_empresa AS B
WHERE        cast(B.IdEmpresa AS varchar(20)) + A.IdTipo_op NOT IN
                             (SELECT        CAST(B.IdEmpresa AS varchar(20)) + A.IdTipo_op
                               FROM            cp_orden_pago_tipo AS A INNER JOIN
                                                         cp_orden_pago_tipo_x_empresa AS B ON A.IdTipo_op = B.IdTipo_op)