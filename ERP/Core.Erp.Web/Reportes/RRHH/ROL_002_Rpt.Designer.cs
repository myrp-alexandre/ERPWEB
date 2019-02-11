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
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.p_IdEmpresa = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdNomina = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdNominaTipo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdPeriodo = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdSucursal = new DevExpress.XtraReports.Parameters.Parameter();
            this.objectDataSource1 = new DevExpress.DataAccess.ObjectBinding.ObjectDataSource(this.components);
            this.GroupHeader1 = new DevExpress.XtraReports.UI.GroupHeaderBand();
            this.SubReporte_RolPago = new DevExpress.XtraReports.UI.XRSubreport();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.xrTable6 = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow13 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell29 = new DevExpress.XtraReports.UI.XRTableCell();
            this.lbl_fecha = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell10 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrPageInfo2 = new DevExpress.XtraReports.UI.XRPageInfo();
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable6)).BeginInit();
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
            this.TopMargin.HeightF = 25F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 25F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrLabel1
            // 
            this.xrLabel1.ExpressionBindings.AddRange(new DevExpress.XtraReports.UI.ExpressionBinding[] {
            new DevExpress.XtraReports.UI.ExpressionBinding("BeforePrint", "Text", "[IdEmpleado]")});
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel1.Text = "xrLabel1";
            this.xrLabel1.Visible = false;
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
            // objectDataSource1
            // 
            this.objectDataSource1.DataSource = typeof(Core.Erp.Info.Reportes.RRHH.ROL_002_Info);
            this.objectDataSource1.Name = "objectDataSource1";
            // 
            // GroupHeader1
            // 
            this.GroupHeader1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel1,
            this.SubReporte_RolPago});
            this.GroupHeader1.GroupFields.AddRange(new DevExpress.XtraReports.UI.GroupField[] {
            new DevExpress.XtraReports.UI.GroupField("NombreCompleto", DevExpress.XtraReports.UI.XRColumnSortOrder.Ascending)});
            this.GroupHeader1.HeightF = 43F;
            this.GroupHeader1.Name = "GroupHeader1";
            this.GroupHeader1.PageBreak = DevExpress.XtraReports.UI.PageBreak.BeforeBand;
            // 
            // SubReporte_RolPago
            // 
            this.SubReporte_RolPago.LocationFloat = new DevExpress.Utils.PointFloat(2.384186E-05F, 23F);
            this.SubReporte_RolPago.Name = "SubReporte_RolPago";
            this.SubReporte_RolPago.ReportSource = new Core.Erp.Web.Reportes.RRHH.ROL_002_RolPago();
            this.SubReporte_RolPago.SizeF = new System.Drawing.SizeF(777.0001F, 20F);
            this.SubReporte_RolPago.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.SubReporte_RolPago_BeforePrint);
            // 
            // PageHeader
            // 
            this.PageHeader.HeightF = 0F;
            this.PageHeader.Name = "PageHeader";
            // 
            // xrTable6
            // 
            this.xrTable6.Borders = ((DevExpress.XtraPrinting.BorderSide)((((DevExpress.XtraPrinting.BorderSide.Left | DevExpress.XtraPrinting.BorderSide.Top) 
            | DevExpress.XtraPrinting.BorderSide.Right) 
            | DevExpress.XtraPrinting.BorderSide.Bottom)));
            this.xrTable6.Font = new System.Drawing.Font("Verdana", 7F, System.Drawing.FontStyle.Bold);
            this.xrTable6.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrTable6.Name = "xrTable6";
            this.xrTable6.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow13});
            this.xrTable6.SizeF = new System.Drawing.SizeF(776F, 20F);
            this.xrTable6.StylePriority.UseBorders = false;
            this.xrTable6.StylePriority.UseFont = false;
            this.xrTable6.StylePriority.UseTextAlignment = false;
            this.xrTable6.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // xrTableRow13
            // 
            this.xrTableRow13.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrTableRow13.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell29,
            this.lbl_fecha,
            this.xrTableCell10});
            this.xrTableRow13.Name = "xrTableRow13";
            this.xrTableRow13.StylePriority.UseBorders = false;
            this.xrTableRow13.Weight = 1D;
            // 
            // xrTableCell29
            // 
            this.xrTableCell29.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrTableCell29.Font = new System.Drawing.Font("Verdana", 7F, System.Drawing.FontStyle.Bold);
            this.xrTableCell29.Name = "xrTableCell29";
            this.xrTableCell29.Padding = new DevExpress.XtraPrinting.PaddingInfo(3, 0, 0, 0, 100F);
            this.xrTableCell29.StylePriority.UseBorders = false;
            this.xrTableCell29.StylePriority.UseFont = false;
            this.xrTableCell29.StylePriority.UsePadding = false;
            this.xrTableCell29.StylePriority.UseTextAlignment = false;
            this.xrTableCell29.Text = "Fecha de impresión:";
            this.xrTableCell29.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            this.xrTableCell29.Weight = 1.3072850806060057D;
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
            this.lbl_fecha.Weight = 5.4924577561624055D;
            // 
            // xrTableCell10
            // 
            this.xrTableCell10.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrTableCell10.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrPageInfo2});
            this.xrTableCell10.Font = new System.Drawing.Font("Verdana", 7F);
            this.xrTableCell10.Name = "xrTableCell10";
            this.xrTableCell10.StylePriority.UseBorders = false;
            this.xrTableCell10.StylePriority.UseFont = false;
            this.xrTableCell10.Weight = 1.7260302896542428D;
            // 
            // xrPageInfo2
            // 
            this.xrPageInfo2.Borders = DevExpress.XtraPrinting.BorderSide.Top;
            this.xrPageInfo2.Font = new System.Drawing.Font("Verdana", 7F);
            this.xrPageInfo2.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrPageInfo2.Name = "xrPageInfo2";
            this.xrPageInfo2.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 5, 0, 0, 100F);
            this.xrPageInfo2.SizeF = new System.Drawing.SizeF(157.1001F, 20F);
            this.xrPageInfo2.StylePriority.UseBorders = false;
            this.xrPageInfo2.StylePriority.UseFont = false;
            this.xrPageInfo2.StylePriority.UsePadding = false;
            this.xrPageInfo2.StylePriority.UseTextAlignment = false;
            this.xrPageInfo2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleRight;
            this.xrPageInfo2.TextFormatString = "Página {0} de {1}";
            // 
            // PageFooter
            // 
            this.PageFooter.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTable6});
            this.PageFooter.HeightF = 20F;
            this.PageFooter.Name = "PageFooter";
            // 
            // ROL_002_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.GroupHeader1,
            this.PageHeader,
            this.PageFooter});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.objectDataSource1});
            this.DataSource = this.objectDataSource1;
            this.Margins = new System.Drawing.Printing.Margins(25, 25, 25, 25);
            this.PageHeight = 584;
            this.PageWidth = 827;
            this.PaperKind = System.Drawing.Printing.PaperKind.Custom;
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.p_IdEmpresa,
            this.p_IdNomina,
            this.p_IdNominaTipo,
            this.p_IdPeriodo,
            this.p_IdSucursal});
            this.Version = "17.2";
            this.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.ROL_002_Rpt_BeforePrint);
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTable6)).EndInit();
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
        private DevExpress.XtraReports.UI.XRSubreport SubReporte_RolPago;
        private DevExpress.XtraReports.UI.GroupHeaderBand GroupHeader1;
        private DevExpress.XtraReports.UI.PageHeaderBand PageHeader;
        private DevExpress.XtraReports.UI.XRLabel xrLabel1;
        private DevExpress.XtraReports.UI.XRTable xrTable6;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow13;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell29;
        private DevExpress.XtraReports.UI.XRTableCell lbl_fecha;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell10;
        private DevExpress.XtraReports.UI.XRPageInfo xrPageInfo2;
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
    }
}
