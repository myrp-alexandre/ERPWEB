CREATE TABLE [dbo].[ro_nomina_tipo_liqui_orden] (
    [IdEmpresa]         INT            NOT NULL,
    [IdNominaTipo]      INT            NOT NULL,
    [IdNominaTipoLiqui] INT            NOT NULL,
    [Orden]             INT            NOT NULL,
    [IdRubro]           VARCHAR (50)   NOT NULL,
    [Formula]           VARCHAR (4000) NULL,
    [EsVisible]         BIT            NULL,
    [Descripcion]       VARCHAR (10)   NULL,
    [FechaIngresa]      DATETIME       NOT NULL,
    [UsuarioIngresa]    VARCHAR (25)   NOT NULL,
    [FechaModifica]     DATETIME       NULL,
    [UsuarioModifica]   VARCHAR (25)   NULL,
    CONSTRAINT [PK_ro_nomina_tipo_liqui_formula] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdNominaTipo] ASC, [IdNominaTipoLiqui] ASC, [Orden] ASC),
    CONSTRAINT [FK_ro_nomina_tipo_liqui_formula_ro_Nomina_Tipoliqui] FOREIGN KEY ([IdEmpresa], [IdNominaTipo], [IdNominaTipoLiqui]) REFERENCES [dbo].[ro_Nomina_Tipoliqui] ([IdEmpresa], [IdNomina_Tipo], [IdNomina_TipoLiqui])
);

