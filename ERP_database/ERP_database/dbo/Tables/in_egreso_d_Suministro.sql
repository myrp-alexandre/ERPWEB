CREATE TABLE [dbo].[in_egreso_d_Suministro] (
    [IdEmpresa]        INT           NOT NULL,
    [IdSucursa]        INT           NOT NULL,
    [IdBodega]         INT           NOT NULL,
    [IdEgresoSumin]    DECIMAL (18)  NOT NULL,
    [IdGasto]          DECIMAL (18)  NOT NULL,
    [IdCentroDeCosto]  DECIMAL (18)  NOT NULL,
    [IdProducto]       DECIMAL (18)  NULL,
    [Cantidad]         FLOAT (53)    NULL,
    [Precio]           FLOAT (53)    NULL,
    [Subtotal]         FLOAT (53)    NULL,
    [observacion]      VARCHAR (200) NULL,
    [IdUsuario]        VARCHAR (20)  NULL,
    [Fecha_Transa]     DATETIME      NULL,
    [IdUsuarioUltModi] VARCHAR (20)  NULL,
    [FechaUltModi]     DATETIME      NULL,
    [IdUsuarioAnula]   VARCHAR (20)  NULL,
    [FechaAnula]       DATETIME      NULL,
    [Estado]           CHAR (1)      NULL,
    CONSTRAINT [PK_in_egreso_d_Suministro] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursa] ASC, [IdBodega] ASC, [IdEgresoSumin] ASC)
);

