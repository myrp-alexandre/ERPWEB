CREATE TABLE [dbo].[fa_vendedor_x_ro_empleado] (
    [IdEmpresa]  INT          NOT NULL,
    [IdVendedor] INT          NOT NULL,
    [IdEmpleado] NUMERIC (18) NOT NULL,
    CONSTRAINT [PK_fa_vendedor_x_ro_empleado] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdVendedor] ASC, [IdEmpleado] ASC),
    CONSTRAINT [FK_fa_vendedor_x_ro_empleado_fa_Vendedor] FOREIGN KEY ([IdEmpresa], [IdVendedor]) REFERENCES [dbo].[fa_Vendedor] ([IdEmpresa], [IdVendedor])
);

