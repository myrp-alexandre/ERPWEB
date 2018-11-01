CREATE TABLE [dbo].[cxc_cobro_tipo_x_cobros_Docxc] (
    [IdCobro_tipo] VARCHAR (20) NOT NULL,
    [Posicion]     INT          NOT NULL,
    CONSTRAINT [PK_cxc_cobro_tipo_x_cobros_Docxc] PRIMARY KEY CLUSTERED ([IdCobro_tipo] ASC),
    CONSTRAINT [FK_cxc_cobro_tipo_x_cobros_Docxc_cxc_cobro_tipo] FOREIGN KEY ([IdCobro_tipo]) REFERENCES [dbo].[cxc_cobro_tipo] ([IdCobro_tipo])
);

