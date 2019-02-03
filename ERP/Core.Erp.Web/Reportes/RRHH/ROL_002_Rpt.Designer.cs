namespace Core.Erp.Web.Reportes.RRHH
{
    partial class ROL_002_Rpt
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.lb_empleado = new DevExpress.XtraReports.UI.XRLabel();
            this.p_IdEmpresa = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdNomina = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdNominaTipo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdPeriodo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdSucursal = new DevExpress.XtraReports.Parameters.Parameter();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.xrTable8 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow13 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell21 = new DevExpress.XtraReports.UI.XRTableCell();
            this.lbl_usuario = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell49 = new DevExpress.XtraReports.UI.XRTableCell();
            this.lbl_fecha = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell50 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrPageInfo2 = new DevExpress.XtraReports.UI.XRPageInfo();
            this.objectDataSource1 = new DevExpress.DataAccess.ObjectBinding.ObjectDataSource(this.components);
            this.GroupHeader1 = new DevExpress.XtraReports.UI.GroupHeaderBand();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.xrSubreport1 = new DevExpress.XtraReports.UI.XRSubreport();
            this.SubReporte_RolPago = new DevExpress.XtraReports.UI.XRSubreport();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable8)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.HeightF = 0F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 38F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.lb_empleado});
            this.BottomMargin.HeightF = 65.625F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // lb_empleado
            // 
            this.lb_empleado.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[IdEmpleado]")});
            this.lb_empleado.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lb_empleado.LocationFloat = new DevExpress.Utils.PointFloat(277.3751F, 23.125F);
            this.lb_empleado.Name = "lb_empleado";
            this.lb_empleado.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.lb_empleado.SizeF = new System.Drawing.SizeF(196.2498F, 19.375F);
            this.lb_empleado.StylePriority.UseFont = false;
            this.lb_empleado.StylePriority.UseTextAlignment = false;
            this.lb_empleado.Text = "IdEmpleado";
            this.lb_empleado.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopCenter;
            // 
            // p_IdEmpresa
            // 
            this.p_IdEmpresa.Name = "p_IdEmpresa";
            this.p_IdEmpresa.Type = typeof(int);
            this.p_IdEmpresa.ValueInfo = "0";
            this.p_IdEmpresa.Visible = false;
            // 
            // p_IdNomina
            // 
            this.p_IdNomina.Name = "p_IdNomina";
            this.p_IdNomina.Type = typeof(int);
            this.p_IdNomina.ValueInfo = "0";
            this.p_IdNomina.Visible = false;
            // 
            // p_IdNominaTipo
            // 
            this.p_IdNominaTipo.Name = "p_IdNominaTipo";
            this.p_IdNominaTipo.Type = typeof(int);
            this.p_IdNominaTipo.ValueInfo = "0";
            this.p_IdNominaTipo.Visible = false;
            // 
            // p_IdPeriodo
            // 
            this.p_IdPeriodo.Name = "p_IdPeriodo";
            this.p_IdPeriodo.Type = typeof(int);
            this.p_IdPeriodo.ValueInfo = "0";
            this.p_IdPeriodo.Visible = false;
            // 
            // p_IdSucursal
            // 
            this.p_IdSucursal.Name = "p_IdSucursal";
            this.p_IdSucursal.Type = typeof(short);
            this.p_IdSucursal.ValueInfo = "0";
            this.p_IdSucursal.Visible = false;
            // 
            // PageFooter
            // 
            this.PageFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTable8});
            this.PageFooter.HeightF = 20F;
            this.PageFooter.Name = "PageFooter";
            // 
            // xrTable8
            // 
            this.xrTable8.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTable8.Font = new System.Drawing.Font("Verdana", 7F, System.Drawing.FontStyle.Bold);
            this.xrTable8.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrTable8.Name = "xrTable8";
            this.xrTable8.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow13});
            this.xrTable8.SizeF = new System.Drawing.SizeF(751F, 20F);
            this.xrTable8.StylePriority.UseBorders = false;
            this.xrTable8.StylePriority.UseFont = false;
            this.xrTable8.StylePriority.UseTextAlignment = false;
            this.xrTable8.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // xrTableRow13
            // 
            this.xrTableRow13.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrTableRow13.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell21,
            this.lbl_usuario,
            this.xrTableCell49,
            this.lbl_fecha,
            this.xrTableCell50});
            this.xrTableRow13.Name = "xrTableRow13";
            this.xrTableRow13.StylePriority.UseBorders = false;
            this.xrTableRow13.Weight = 1D;
            // 
            // xrTableCell21
            // 
            this.xrTableCell21.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrTableCell21.Font = new System.Drawing.Font("Verdana", 7F, System.Drawing.FontStyle.Bold);
            this.xrTableCell21.Name = "xrTableCell21";
            this.xrTableCell21.Padding = new DevExpress.XtraPrinting.PaddingInfo(5, 0, 0, 0, 100F);
            this.xrTableCell21.StylePriority.UseBorders = false;
            this.xrTableCell21.StylePriority.UseFont = false;
            this.xrTableCell21.StylePriority.UsePadding = false;
            this.xrTableCell21.StylePriority.UseTextAlignment = false;
            this.xrTableCell21.Text = "Usuario:";
            this.xrTableCell21.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            this.xrTableCell21.Weight = 0.74666676491777884D;
            // 
            // lbl_usuario
            // 
            this.lbl_usuario.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.lbl_usuario.Font = new System.Drawing.Font("Verdana", 7F);
            this.lbl_usuario.Name = "lbl_usuario";
            this.lbl_usuario.Padding = new DevExpress.XtraPrinting.PaddingInfo(5, 0, 0, 0, 100F);
            this.lbl_usuario.StylePriority.UseBorders = false;
            this.lbl_usuario.StylePriority.UseFont = false;
            this.lbl_usuario.StylePriority.UsePadding = false;
            this.lbl_usuario.StylePriority.UseTextAlignment = false;
            this.lbl_usuario.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            this.lbl_usuario.Weight = 2.1333336640589793D;
            // 
            // xrTableCell49
            // 
            this.xrTableCell49.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrTableCell49.Font = new System.Drawing.Font("Verdana", 7F, System.Drawing.FontStyle.Bold);
            this.xrTableCell49.Name = "xrTableCell49";
            this.xrTableCell49.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 5, 0, 0, 100F);
            this.xrTableCell49.StylePriority.UseBorders = false;
            this.xrTableCell49.StylePriority.UseFont = false;
            this.xrTableCell49.StylePriority.UsePadding = false;
            this.xrTableCell49.StylePriority.UseTextAlignment = false;
            this.xrTableCell49.Text = "Fecha de impresión:";
            this.xrTableCell49.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.xrTableCell49.Weight = 1.9199985793935255D;
            // 
            // lbl_fecha
            // 
            this.lbl_fecha.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.lbl_fecha.Font = new System.Drawing.Font("Verdana", 7F);
            this.lbl_fecha.Name = "lbl_fecha";
            this.lbl_fecha.Padding = new DevExpress.XtraPrinting.PaddingInfo(5, 0, 0, 0, 100F);
            this.lbl_fecha.StylePriority.UseBorders = false;
            this.lbl_fecha.StylePriority.UseFont = false;
            this.lbl_fecha.StylePriority.UsePadding = false;
            this.lbl_fecha.StylePriority.UseTextAlignment = false;
            this.lbl_fecha.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            this.lbl_fecha.Weight = 1.4933332980285115D;
            // 
            // xrTableCell50
            // 
            this.xrTableCell50.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrTableCell50.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrPageInfo2});
            this.xrTableCell50.Font = new System.Drawing.Font("Verdana", 7F);
            this.xrTableCell50.Name = "xrTableCell50";
            this.xrTableCell50.StylePriority.UseBorders = false;
            this.xrTableCell50.StylePriority.UseFont = false;
            this.xrTableCell50.Weight = 1.7066673583468051D;
            // 
            // xrPageInfo2
            // 
            this.xrPageInfo2.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrPageInfo2.Font = new System.Drawing.Font("Verdana", 7F);
            this.xrPageInfo2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrPageInfo2.Name = "xrPageInfo2";
            this.xrPageInfo2.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 5, 0, 0, 100F);
            this.xrPageInfo2.SizeF = new System.Drawing.SizeF(160F, 20F);
            this.xrPageInfo2.StylePriority.UseBorders = false;
            this.xrPageInfo2.StylePriority.UseFont = false;
            this.xrPageInfo2.StylePriority.UsePadding = false;
            this.xrPageInfo2.StylePriority.UseTextAlignment = false;
            this.xrPageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.xrPageInfo2.TextFormatString = "Página {0} de {1}";
            // 
            // objectDataSource1
            // 
            this.objectDataSource1.DataSource = typeof(Core.Erp.Info.Reportes.RRHH.ROL_002_Info);
            this.objectDataSource1.Name = "objectDataSource1";
            // 
            // GroupHeader1
            // 
            this.GroupHeader1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrSubreport1,
            this.SubReporte_RolPago});
            this.GroupHeader1.GroupFields.AddRange(new DevExpress.XtraReports.UI.GroupField[] {
            new DevExpress.XtraReports.UI.GroupField("IdEmpleado", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)});
            this.GroupHeader1.HeightF = 73.95834F;
            this.GroupHeader1.Name = "GroupHeader1";
            this.GroupHeader1.PageBreak = DevExpress.XtraReports.UI.PageBreak.BeforeBand;
            // 
            // PageHeader
            // 
            this.PageHeader.HeightF = 0F;
            this.PageHeader.Name = "PageHeader";
            // 
            // xrSubreport1
            // 
            this.xrSubreport1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 45.62502F);
            this.xrSubreport1.Name = "xrSubreport1";
            this.xrSubreport1.ReportSource = new Core.Erp.Web.Reportes.RRHH.ROL_002_RolPago();
            this.xrSubreport1.SizeF = new System.Drawing.SizeF(751F, 20F);
            this.xrSubreport1.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.xrSubreport1_BeforePrint);
            // 
            // SubReporte_RolPago
            // 
            this.SubReporte_RolPago.LocationFloat = new DevExpress.Utils.PointFloat(0F, 10.00001F);
            this.SubReporte_RolPago.Name = "SubReporte_RolPago";
            this.SubReporte_RolPago.ReportSource = new Core.Erp.Web.Reportes.RRHH.ROL_002_RolPago();
            this.SubReporte_RolPago.SizeF = new System.Drawing.SizeF(751F, 20F);
            this.SubReporte_RolPago.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.SubReporte_RolPago_BeforePrint);
            // 
            // ROL_002_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.PageFooter,
            this.GroupHeader1,
            this.PageHeader});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.objectDataSource1});
            this.DataSource = this.objectDataSource1;
            this.Margins = new System.Drawing.Printing.Margins(38, 38, 38, 66);
            this.PageHeight = 1169;
            this.PageWidth = 827;
            this.PaperKind = System.Drawing.Printing.PaperKind.A4;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.p_IdEmpresa,
            this.p_IdNomina,
            this.p_IdNominaTipo,
            this.p_IdPeriodo,
            this.p_IdSucursal});
            this.Version = "17.2";
            this.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.ROL_002_Rpt_BeforePrint);
            ((System.ComponentModel.ISupportInitialize)(this.xrTable8)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.DataAccess.ObjectBinding.ObjectDataSource objectDataSource1;
        public DevExpress.XtraReports.Parameters.Parameter p_IdNomina;
        public DevExpress.XtraReports.Parameters.Parameter p_IdNominaTipo;
        public DevExpress.XtraReports.Parameters.Parameter p_IdPeriodo;
        public DevExpress.XtraReports.Parameters.Parameter p_IdEmpresa;
        public DevExpress.XtraReports.Parameters.Parameter p_IdSucursal;
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
        private DevExpress.XtraReports.UI.XRTable xrTable8;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow13;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell21;
        private DevExpress.XtraReports.UI.XRTableCell lbl_usuario;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell49;
        private DevExpress.XtraReports.UI.XRTableCell lbl_fecha;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell50;
        private DevExpress.XtraReports.UI.XRPageInfo xrPageInfo2;
        private DevExpress.XtraReports.UI.XRSubreport SubReporte_RolPago;
        private DevExpress.XtraReports.UI.XRSubreport xrSubreport1;
        private DevExpress.XtraReports.UI.GroupHeaderBand GroupHeader1;
        private DevExpress.XtraReports.UI.PageHeaderBand PageHeader;
        private DevExpress.XtraReports.UI.XRLabel lb_empleado;
    }
}
