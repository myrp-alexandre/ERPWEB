CREATE TABLE [dbo].[cp_conciliacion] (
    [IdEmpresa]           INT           NOT NULL,
    [IdConciliacion]      NUMERIC (18)  NOT NULL,
    [Fecha]               DATE          NOT NULL,
    [Observacion]         VARCHAR (250) NOT NULL,
    [Estado]              CHAR (1)      NOT NULL,
    [IdUsuarioUltMod]     VARCHAR (20)  NULL,
    [Fecha_Transac]       DATETIME      NULL,
    [Fecha_UltMod]        DATETIME      NULL,
    [IdUsuarioUltAnu]     VARCHAR (20)  NULL,
    [MotivoAnu]           VARCHAR (150) NULL,
    [nom_pc]              VARCHAR (50)  NULL,
    [Fecha_UltAnu]        DATETIME      NULL,
    [ip]                  VARCHAR (50)  NULL,
    [IdCancelacion]       NUMERIC (18)  NULL,
    [Tipo_detalle]        VARCHAR (20)  NULL,
    [Tipo]                VARCHAR (50)  NULL,
    [IdEmpresa_cbtecble]  INT           NULL,
    [IdTipoCbte_cbtecble] INT           NULL,
    [IdCbteCble_cbtecble] NUMERIC (18)  NULL,
    CONSTRAINT [PK_cp_conciliacion] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdConciliacion] ASC),
    CONSTRAINT [FK_cp_conciliacion_ct_cbtecble] FOREIGN KEY ([IdEmpresa_cbtecble], [IdTipoCbte_cbtecble], [IdCbteCble_cbtecble]) REFERENCES [dbo].[ct_cbtecble] ([IdEmpresa], [IdTipoCbte], [IdCbteCble])
);

