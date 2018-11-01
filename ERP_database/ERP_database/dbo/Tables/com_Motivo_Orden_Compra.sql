CREATE TABLE [dbo].[com_Motivo_Orden_Compra] (
    [IdEmpresa]       INT           NOT NULL,
    [IdMotivo]        INT           NOT NULL,
    [Cod_Motivo]      VARCHAR (20)  NOT NULL,
    [Descripcion]     VARCHAR (250) NOT NULL,
    [estado]          CHAR (1)      NOT NULL,
    [Fecha_Transac]   DATETIME      NULL,
    [Fecha_UltMod]    DATETIME      NULL,
    [IdUsuarioUltMod] VARCHAR (20)  NULL,
    [FechaHoraAnul]   DATETIME      NULL,
    [IdUsuarioUltAnu] VARCHAR (20)  NULL,
    [MotivoAnulacion] VARCHAR (250) NULL,
    CONSTRAINT [PK_com_Motivo_Orden_Compra] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdMotivo] ASC)
);

