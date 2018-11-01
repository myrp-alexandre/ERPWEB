CREATE TABLE [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente] (
    [IdEmpresa]                 INT           NOT NULL,
    [IdTarifario]               NUMERIC (18)  NOT NULL,
    [codTarifario]              VARCHAR (50)  NULL,
    [nom_tarifario]             VARCHAR (500) NOT NULL,
    [observacion]               VARCHAR (250) NOT NULL,
    [fecha_inicio]              DATETIME      NOT NULL,
    [fecha_fin]                 DATETIME      NOT NULL,
    [IdUsuario]                 VARCHAR (20)  NULL,
    [Estado]                    BIT           NOT NULL,
    [nom_pc]                    VARCHAR (50)  NULL,
    [ip]                        VARCHAR (25)  NULL,
    [IdUsuarioUltMod]           VARCHAR (20)  NULL,
    [FechaUltMod]               DATE          NULL,
    [IdUsuarioUltAnu]           VARCHAR (25)  NULL,
    [Fecha_UltAnu]              DATE          NULL,
    [MotiAnula]                 VARCHAR (100) NULL,
    [IdCentroCosto]             VARCHAR (20)  NOT NULL,
    [valor_minimo_movilizacion] FLOAT (53)    NOT NULL,
    [por_ganancia_inicial]      FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_fa_contrato_facturacion_x_cliente] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarifario] ASC)
);

