namespace Core.Erp.Web.Reportes.CuentasPorPagar
{
    partial class CXP_012_Rpt
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
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.xrSubreport1 = new DevExpress.XtraReports.UI.XRSubreport();
            this.xrSubreport2 = new DevExpress.XtraReports.UI.XRSubreport();
            this.xrSubreport3 = new DevExpress.XtraReports.UI.XRSubreport();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrSubreport3,
            this.xrSubreport2,
            this.xrSubreport1});
            this.Detail.HeightF = 146.875F;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 16.66667F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 100F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // xrSubreport1
            // 
            this.xrSubreport1.LocationFloat = new DevExpress.Utils.PointFloat(61.45833F, 10.00001F);
            this.xrSubreport1.Name = "xrSubreport1";
            this.xrSubreport1.ReportSource = new Core.Erp.Web.Reportes.CuentasPorPagar.CXP_012_Rpt_retencion();
            this.xrSubreport1.SizeF = new System.Drawing.SizeF(560.4167F, 23F);
            // 
            // xrSubreport2
            // 
            this.xrSubreport2.LocationFloat = new DevExpress.Utils.PointFloat(61.45833F, 54.75F);
            this.xrSubreport2.Name = "xrSubreport2";
            this.xrSubreport2.ReportSource = new Core.Erp.Web.Reportes.CuentasPorPagar.CXP_012_Rpt_retencion();
            this.xrSubreport2.SizeF = new System.Drawing.SizeF(560.4167F, 23F);
            // 
            // xrSubreport3
            // 
            this.xrSubreport3.LocationFloat = new DevExpress.Utils.PointFloat(61.45833F, 91.20833F);
            this.xrSubreport3.Name = "xrSubreport3";
            this.xrSubreport3.ReportSource = new Core.Erp.Web.Reportes.CuentasPorPagar.CXP_012_Rpt_retencion();
            this.xrSubreport3.SizeF = new System.Drawing.SizeF(560.4167F, 23F);
            // 
            // CXP_012_Rpt
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin});
            this.Margins = new System.Drawing.Printing.Margins(100, 100, 17, 100);
            this.Version = "17.2";
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.XRSubreport xrSubreport3;
        private DevExpress.XtraReports.UI.XRSubreport xrSubreport2;
        private DevExpress.XtraReports.UI.XRSubreport xrSubreport1;
    }
}
