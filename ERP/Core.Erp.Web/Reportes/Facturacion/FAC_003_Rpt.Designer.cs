namespace Core.Erp.Web.Reportes.Facturacion
{
    partial class FAC_003_Rpt
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
            this.objectDataSource1 = new DevExpress.DataAccess.ObjectBinding.ObjectDataSource(this.components);
            this.PageFooter = new DevExpress.XtraReports.UI.PageFooterBand();
            this.p_IdEmpresa = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdSucursal = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdBodega = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_IdCbteVta = new DevExpress.XtraReports.Parameters.Parameter();
            this.p_mostrar_cuotas = new DevExpress.XtraReports.Parameters.Parameter();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.subtotalIVA_sinDscto = new DevExpress.XtraReports.UI.CalculatedField();
            this.Subtotal0_sinDscto = new DevExpress.XtraReports.UI.CalculatedField();
            this.ReportFooter = new DevExpress.XtraReports.UI.ReportFooterBand();
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.HeightF = 30F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 135F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 0F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // objectDataSource1
            // 
            this.objectDataSource1.DataSource = typeof(Core.Erp.Info.Reportes.Facturacion.FAC_003_Info);
            this.objectDataSource1.Name = "objectDataSource1";
            // 
            // PageFooter
            // 
            this.PageFooter.HeightF = 154.5105F;
            this.PageFooter.Name = "PageFooter";
            // 
            // p_IdEmpresa
            // 
            this.p_IdEmpresa.Name = "p_IdEmpresa";
            this.p_IdEmpresa.Visible = false;
            // 
            // p_IdSucursal
            // 
            this.p_IdSucursal.Name = "p_IdSucursal";
            this.p_IdSucursal.Visible = false;
            // 
            // p_IdBodega
            // 
            this.p_IdBodega.Name = "p_IdBodega";
            this.p_IdBodega.Visible = false;
            // 
            // p_IdCbteVta
            // 
            this.p_IdCbteVta.Name = "p_IdCbteVta";
            this.p_IdCbteVta.Visible = false;
            // 
            // p_mostrar_cuotas
            // 
            this.p_mostrar_cuotas.Name = "p_mostrar_cuotas";
            this.p_mostrar_cuotas.Visible = false;
            // 
            // ReportHeader
            // 
            this.ReportHeader.HeightF = 266.2915F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // subtotalIVA_sinDscto
            // 
            this.subtotalIVA_sinDscto.Expression = "Iif([subtotal_iva] > 0, [vt_cantidad]*[vt_Precio],0 )";
            this.subtotalIVA_sinDscto.Name = "subtotalIVA_sinDscto";
            // 
            // Subtotal0_sinDscto
            // 
            this.Subtotal0_sinDscto.Expression = "Iif([subtotal_iva] = 0,[vt_cantidad]*[vt_Precio] ,0 )";
            this.Subtotal0_sinDscto.Name = "Subtotal0_sinDscto";
            // 
            // ReportFooter
            // 
            this.ReportFooter.HeightF = 100F;
            this.ReportFooter.Name = "ReportFooter";
            // 
            // FAC_003_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.PageFooter,
            this.ReportHeader,
            this.ReportFooter});
            this.CalculatedFields.AddRange(new DevExpress.XtraReports.UI.CalculatedField[] {
            this.subtotalIVA_sinDscto,
            this.Subtotal0_sinDscto});
            this.ComponentStorage.AddRange(new System.ComponentModel.IComponent[] {
            this.objectDataSource1});
            this.DataSource = this.objectDataSource1;
            this.Font = new System.Drawing.Font("Verdana", 8F);
            this.Margins = new System.Drawing.Printing.Margins(52, 0, 135, 0);
            this.PageHeight = 1167;
            this.PageWidth = 827;
            this.PaperKind = System.Drawing.Printing.PaperKind.Custom;
            this.PaperName = "CUSTOM";
            this.Parameters.AddRange(new DevExpress.XtraReports.Parameters.Parameter[] {
            this.p_IdEmpresa,
            this.p_IdSucursal,
            this.p_IdBodega,
            this.p_IdCbteVta,
            this.p_mostrar_cuotas});
            this.SnapGridSize = 13.02083F;
            this.Version = "17.2";
            this.BeforePrint += new System.Drawing.Printing.PrintEventHandler(this.FAC_003_Rpt_BeforePrint);
            ((System.ComponentModel.ISupportInitialize)(this.objectDataSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.DataAccess.ObjectBinding.ObjectDataSource objectDataSource1;
        private DevExpress.XtraReports.UI.PageFooterBand PageFooter;
        public DevExpress.XtraReports.Parameters.Parameter p_IdEmpresa;
        public DevExpress.XtraReports.Parameters.Parameter p_IdSucursal;
        public DevExpress.XtraReports.Parameters.Parameter p_IdBodega;
        public DevExpress.XtraReports.Parameters.Parameter p_IdCbteVta;
        public DevExpress.XtraReports.Parameters.Parameter p_mostrar_cuotas;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
        private DevExpress.XtraReports.UI.CalculatedField subtotalIVA_sinDscto;
        private DevExpress.XtraReports.UI.CalculatedField Subtotal0_sinDscto;
        private DevExpress.XtraReports.UI.ReportFooterBand ReportFooter;
    }
}
