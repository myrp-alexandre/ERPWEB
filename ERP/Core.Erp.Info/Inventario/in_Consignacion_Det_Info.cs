using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Inventario
{
    public class in_Consignacion_det_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdConsignacion { get; set; }
        public int Secuencial { get; set; }
        public decimal IdProducto { get; set; }
        public string IdUnidadMedida { get; set; }
        public int Cantidad { get; set; }
        public double Costo { get; set; }
        public string Observacion { get; set; }

        #region Campos de la vista
        public string pr_descripcion { get; set; }
        #endregion
    }
}
