CREATE TABLE [dbo].[tb_persona_direccion_tipo] (
    [IdTipoDireccion]   INT          NOT NULL,
    [nom_TipoDireccion] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_tb_persona_direccion_tipo] PRIMARY KEY CLUSTERED ([IdTipoDireccion] ASC)
);

