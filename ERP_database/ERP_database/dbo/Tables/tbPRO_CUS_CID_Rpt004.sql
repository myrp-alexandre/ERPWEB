CREATE TABLE [dbo].[tbPRO_CUS_CID_Rpt004] (
    [IdEmpresa]      INT            NOT NULL,
    [IdUsuario]      VARCHAR (20)   NOT NULL,
    [Fecha_Transac]  DATETIME       NOT NULL,
    [nom_pc]         VARCHAR (50)   NOT NULL,
    [IdSucursal]     INT            NOT NULL,
    [IdOrdenCompra]  NUMERIC (18)   NOT NULL,
    [valorunitario]  FLOAT (53)     NULL,
    [valortotal]     FLOAT (53)     NULL,
    [ivaxreg]        FLOAT (53)     NULL,
    [oc_fecha]       DATE           NULL,
    [pr_nombre]      VARCHAR (100)  NULL,
    [Solicitante]    VARCHAR (50)   NULL,
    [pr_descripcion] NVARCHAR (500) NULL,
    [IdUnidadMedida] VARCHAR (5)    NULL,
    [pesoxreg]       FLOAT (53)     NULL,
    [pr_peso]        FLOAT (53)     NULL,
    [IdProducto]     NUMERIC (18)   NOT NULL,
    [cantidad]       FLOAT (53)     NULL,
    [Secuencia]      INT            NULL
);

