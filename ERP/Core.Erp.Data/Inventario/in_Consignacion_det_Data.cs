using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Consignacion_det_Data
    {
        public bool GuardarBD(in_Consignacion_det_Info info)
        {
            try
            {
                using (Entities_inventario db = new Entities_inventario())
                {
                    db.in_consignacion_det.Add(new in_consignacion_det
                    {
                        //IdTarjeta = get_id(),
                        //NombreTarjeta = info.NombreTarjeta,
                        //Estado = info.Estado = true,
                        //IdUsuario = info.IdUsuario,
                        //Fecha_Transac = DateTime.Now
                    });

                    db.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
