CREATE TABLE [dbo].[cxc_conciliacion_tipo] (
    [IdTipoConciliacion] VARCHAR (20) NOT NULL,
    [Descripcion]        VARCHAR (50) NULL,
    CONSTRAINT [PK_cxc_conciliacion_tipo] PRIMARY KEY CLUSTERED ([IdTipoConciliacion] ASC)
);

