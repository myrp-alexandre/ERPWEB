CREATE TABLE [dbo].[tbPRD_Rpt_RPRD001] (
    [IdEmpresa]         INT            NOT NULL,
    [IdSucursal]        INT            NOT NULL,
    [IdBodega]          INT            NOT NULL,
    [IdMovi_inven_tipo] INT            NOT NULL,
    [IdNumMovi]         NUMERIC (10)   NOT NULL,
    [Secuencia]         INT            NOT NULL,
    [IdProducto]        NUMERIC (10)   NOT NULL,
    [CodigoBarra]       NVARCHAR (100) NOT NULL,
    [IdUsuario]         VARCHAR (20)   NULL,
    [Fecha_Transac]     DATETIME       NULL,
    [nom_pc]            VARCHAR (50)   NULL,
    [pr_descripcion]    VARCHAR (50)   NULL
);

