CREATE TABLE [dbo].[ro_DocumentoxEmp] (
    [IdEmpresa]      INT             NOT NULL,
    [IdEmpleado]     NUMERIC (18)    NOT NULL,
    [IdDocumento]    NUMERIC (18)    NOT NULL,
    [Dc_Nombre]      VARCHAR (200)   NOT NULL,
    [Dc_Descripcion] VARCHAR (500)   NOT NULL,
    [Documento]      VARBINARY (MAX) NULL,
    [tipo]           NCHAR (10)      NOT NULL,
    [FechaReg]       DATETIME        NOT NULL,
    [FechaElimin]    DATETIME        NULL,
    [UsuarioElimin]  CHAR (20)       NULL,
    [MotivoElimin]   VARCHAR (500)   NULL,
    [Estado]         CHAR (1)        NOT NULL,
    CONSTRAINT [PK_ro_DocumentoxEmp] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEmpleado] ASC, [IdDocumento] ASC),
    CONSTRAINT [FK_ro_DocumentoxEmp_ro_empleado] FOREIGN KEY ([IdEmpresa], [IdEmpleado]) REFERENCES [dbo].[ro_empleado] ([IdEmpresa], [IdEmpleado])
);

