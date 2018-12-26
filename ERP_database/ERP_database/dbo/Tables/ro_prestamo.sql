
CREATE TABLE [dbo].[ro_prestamo](
	[IdEmpresa] [int] NOT NULL,
	[IdPrestamo] [numeric](18, 0) NOT NULL,
	[IdEmpleado] [numeric](18, 0) NOT NULL,
	[IdRubro] [varchar](50) NOT NULL,
	[descuento_mensual] [bit] NOT NULL,
	[descuento_quincena] [bit] NOT NULL,
	[descuento_men_quin] [bit] NOT NULL,
	[descuento_ben_soc] [bit] NOT NULL,
	[Estado] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[MontoSol] [float] NOT NULL,
	[NumCuotas] [int] NOT NULL,
	[Fecha_PriPago] [date] NOT NULL,
	[Observacion] [varchar](max) NOT NULL,
	[IdEmpresa_dc] [int] NULL,
	[IdTipoCbte] [int] NULL,
	[IdCbteCble] [numeric](18, 0) NULL,
	[IdEmpresa_op] [int] NULL,
	[IdOrdenPago] [numeric](18, 0) NULL,
	[IdUsuarioAprueba] [varchar](50) NULL,
	[EstadoAprob] [varchar](10) NULL,
	[IdUsuario] [varchar](20) NOT NULL,
	[Fecha_Transac] [datetime] NOT NULL,
	[IdUsuarioUltMod] [varchar](20) NULL,
	[Fecha_UltMod] [datetime] NULL,
	[IdUsuarioUltAnu] [varchar](20) NULL,
	[Fecha_UltAnu] [datetime] NULL,
	[MotiAnula] [varchar](200) NULL,
 CONSTRAINT [PK_ro_prestamo] PRIMARY KEY CLUSTERED 
(
	[IdEmpresa] ASC,
	[IdPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[ro_prestamo]  WITH CHECK ADD  CONSTRAINT [FK_ro_prestamo_cp_orden_pago] FOREIGN KEY([IdEmpresa_op], [IdOrdenPago])
REFERENCES [dbo].[cp_orden_pago] ([IdEmpresa], [IdOrdenPago])
GO

ALTER TABLE [dbo].[ro_prestamo] CHECK CONSTRAINT [FK_ro_prestamo_cp_orden_pago]
GO

ALTER TABLE [dbo].[ro_prestamo]  WITH CHECK ADD  CONSTRAINT [FK_ro_prestamo_ct_cbtecble] FOREIGN KEY([IdEmpresa_dc], [IdTipoCbte], [IdCbteCble])
REFERENCES [dbo].[ct_cbtecble] ([IdEmpresa], [IdTipoCbte], [IdCbteCble])
GO

ALTER TABLE [dbo].[ro_prestamo] CHECK CONSTRAINT [FK_ro_prestamo_ct_cbtecble]
GO

ALTER TABLE [dbo].[ro_prestamo]  WITH CHECK ADD  CONSTRAINT [FK_ro_prestamo_ro_catalogo] FOREIGN KEY([EstadoAprob])
REFERENCES [dbo].[ro_catalogo] ([CodCatalogo])
GO

ALTER TABLE [dbo].[ro_prestamo] CHECK CONSTRAINT [FK_ro_prestamo_ro_catalogo]
GO

ALTER TABLE [dbo].[ro_prestamo]  WITH NOCHECK ADD  CONSTRAINT [FK_ro_prestamo_ro_empleado] FOREIGN KEY([IdEmpresa], [IdEmpleado])
REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado])
GO

ALTER TABLE [dbo].[ro_prestamo] CHECK CONSTRAINT [FK_ro_prestamo_ro_empleado]
GO

ALTER TABLE [dbo].[ro_prestamo]  WITH CHECK ADD  CONSTRAINT [FK_ro_prestamo_ro_rubro_tipo] FOREIGN KEY([IdEmpresa], [IdRubro])
REFERENCES [dbo].[ro_rubro_tipo] ([IdEmpresa], [IdRubro])
GO

ALTER TABLE [dbo].[ro_prestamo] CHECK CONSTRAINT [FK_ro_prestamo_ro_rubro_tipo]
GO


