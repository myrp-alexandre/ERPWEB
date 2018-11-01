CREATE TABLE [dbo].[ct_cbtecble_Plantilla] (
    [IdEmpresa]        INT           NOT NULL,
    [IdTipoCbte]       INT           NOT NULL,
    [IdPlantilla]      NUMERIC (18)  NOT NULL,
    [cb_Fecha]         DATETIME      NOT NULL,
    [cb_Observacion]   VARCHAR (700) NOT NULL,
    [cb_Estado]        CHAR (1)      NOT NULL,
    [IdUsuario]        VARCHAR (20)  NOT NULL,
    [IdUsuarioAnu]     VARCHAR (20)  NULL,
    [cb_MotivoAnu]     VARCHAR (100) NULL,
    [IdUsuarioUltModi] VARCHAR (20)  NULL,
    [cb_FechaAnu]      DATETIME      NULL,
    [cb_FechaTransac]  DATETIME      NOT NULL,
    [cb_FechaUltModi]  DATETIME      NULL,
    CONSTRAINT [PK_ct_cbtecble_Plantilla] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTipoCbte] ASC, [IdPlantilla] ASC),
    CONSTRAINT [FK_ct_cbtecble_Plantilla_ct_cbtecble_tipo] FOREIGN KEY ([IdEmpresa], [IdTipoCbte]) REFERENCES [dbo].[ct_cbtecble_tipo] ([IdEmpresa], [IdTipoCbte])
);

