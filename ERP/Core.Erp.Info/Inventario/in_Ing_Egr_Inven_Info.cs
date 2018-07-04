using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Inventario
{
    public class in_Ing_Egr_Inven_Info
    {
        public int IdEmpresa { get; set; }
        [Required(ErrorMessage = ("El campo sucursal es obligatorio"))]
        public int IdSucursal { get; set; }
        [Required(ErrorMessage = ("El campo tipo es obligatorio"))]

        public int IdMovi_inven_tipo { get; set; }

        public decimal IdNumMovi { get; set; }

        public Nullable<int> IdBodega { get; set; }
        public string signo { get; set; }
        public string CodMoviInven { get; set; }
        public string cm_observacion { get; set; }
        public System.DateTime cm_fecha { get; set; }
        public string IdUsuario { get; set; }
        public string Estado { get; set; }
        public string MotivoAnulacion { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltModi { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdusuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string nom_pc { get; set; }
        public string ip { get; set; }
        [Required(ErrorMessage = ("El campo motivo es obligatorio"))]

        public Nullable<int> IdMotivo_Inv { get; set; }
        public Nullable<decimal> IdResponsable { get; set; }


        //Campos que no existen en la tabla
        public List<in_Ing_Egr_Inven_det_Info> lst_in_Ing_Egr_Inven_det { get; set; }
        public in_Ing_Egr_Inven_Info()
        {
            lst_in_Ing_Egr_Inven_det = new List<in_Ing_Egr_Inven_det_Info>();
        }
    }
}
