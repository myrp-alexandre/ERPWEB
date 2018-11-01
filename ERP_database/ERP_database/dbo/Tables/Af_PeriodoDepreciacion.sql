CREATE TABLE [dbo].[Af_PeriodoDepreciacion] (
    [IdPeriodoDeprec]   VARCHAR (20) NOT NULL,
    [Descripcion]       VARCHAR (50) NULL,
    [Valor_Ciclo_Anual] INT          NULL,
    CONSTRAINT [PK_Af_PeriodoDepreciacion] PRIMARY KEY CLUSTERED ([IdPeriodoDeprec] ASC)
);

