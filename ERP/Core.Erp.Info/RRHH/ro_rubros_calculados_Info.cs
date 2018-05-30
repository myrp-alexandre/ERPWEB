using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_rubros_calculados_Info
    {
        public int IdEmpresa { get; set; }
        [Required(ErrorMessage = "El campo días trabajados es obligatorio")]
        public string IdRubro_dias_trabajados { get; set; }
        [Required(ErrorMessage = "El campo total ingreso es obligatorio")]
        public string IdRubro_tot_ing { get; set; }
        [Required(ErrorMessage = "El campo total egreso es obligatorio")]
        public string IdRubro_tot_egr { get; set; }
        [Required(ErrorMessage = "El campo aporte personal es obligatorio")]
        public string IdRubro_iess_perso { get; set; }
        [Required(ErrorMessage = "El campo sueldo es obligatorio")]
        public string IdRubro_sueldo { get; set; }
        [Required(ErrorMessage = "El campo total a pagar es obligatorio")]

        public string IdRubro_tot_pagar { get; set; }

    }
}
