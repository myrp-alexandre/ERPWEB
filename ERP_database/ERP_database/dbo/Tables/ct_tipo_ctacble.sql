CREATE TABLE [dbo].[ct_tipo_ctacble] (
    [IdTipoCtaCble]   VARCHAR (10)  NOT NULL,
    [nom_TipoCtaCble] VARCHAR (150) NULL,
    [estado]          CHAR (1)      NULL,
    CONSTRAINT [PK_ct_tipo_cta_cble] PRIMARY KEY CLUSTERED ([IdTipoCtaCble] ASC)
);

