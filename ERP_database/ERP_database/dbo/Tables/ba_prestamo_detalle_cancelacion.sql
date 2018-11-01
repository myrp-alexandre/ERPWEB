CREATE TABLE [dbo].[ba_prestamo_detalle_cancelacion] (
    [IdEmpresa]        INT           NOT NULL,
    [IdPrestamo]       NUMERIC (18)  NOT NULL,
    [NumCuota]         INT           NOT NULL,
    [Secuencia]        INT           NOT NULL,
    [Monto_Canc]       FLOAT (53)    NOT NULL,
    [Saldo]            FLOAT (53)    NOT NULL,
    [FechaPago]        DATETIME      NOT NULL,
    [Observacion_canc] VARCHAR (250) NULL,
    [IdUsuario]        VARCHAR (20)  NOT NULL,
    [Fecha_Transac]    DATETIME      NOT NULL,
    [IdUsuarioUltMod]  VARCHAR (20)  NULL,
    [Fecha_UltMod]     DATETIME      NULL,
    [IdUsuarioUltAnu]  VARCHAR (20)  NULL,
    [Fecha_UltAnu]     DATETIME      NULL,
    [nom_pc]           VARCHAR (50)  NULL,
    [ip]               VARCHAR (25)  NULL,
    [MotiAnula]        VARCHAR (200) NULL,
    CONSTRAINT [PK_ba_prestamo_detalle_cancelacion] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdPrestamo] ASC, [NumCuota] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_ba_prestamo_detalle_cancelacion_ba_prestamo_detalle] FOREIGN KEY ([IdEmpresa], [IdPrestamo], [NumCuota]) REFERENCES [dbo].[ba_prestamo_detalle] ([IdEmpresa], [IdPrestamo], [NumCuota])
);

