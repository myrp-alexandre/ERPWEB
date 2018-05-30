using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Facturacion
{
    public class fa_PuntoVta_Info
    {
        public int IdEmpresa { get; set; }

        [Required(ErrorMessage = "El campo sucursal es obligatorio")]
        public int IdSucursal { get; set; }
        public int IdPuntoVta { get; set; }
        [Required(ErrorMessage = "El campo código es obligatorio")]
        [StringLength(50, MinimumLength = 0, ErrorMessage = "el campo código debe tener máximo 50")]
        public string cod_PuntoVta { get; set; }
        [Required(ErrorMessage = "El campo descripción es obligatorio")]
        [StringLength(150, MinimumLength = 1, ErrorMessage = "el campo descripción debe tener mínimo 1 caracter y máximo 150")]
        public string nom_PuntoVta { get; set; }
        public bool estado { get; set; }
        [Required(ErrorMessage = "El campo bodega es obligatorio")]
        public Nullable<int> IdBodega { get; set; }
    }
}
