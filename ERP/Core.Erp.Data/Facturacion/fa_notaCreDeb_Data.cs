using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Facturacion
{
    public class fa_notaCreDeb_Data
    {
        public List<fa_notaCreDeb_Info> get_list(int IdEmpresa, DateTime Fecha_ini, DateTime Fecha_fin)
        {
            try
            {
                List<fa_notaCreDeb_Info> Lista;
                Fecha_ini = Fecha_ini.Date;
                Fecha_fin = Fecha_fin.Date;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    Lista = (from q in Context.vwfa_notaCreDeb
                             where q.IdEmpresa == IdEmpresa
                             && Fecha_ini <= q.no_fecha
                             && q.no_fecha <= Fecha_fin
                             select new fa_notaCreDeb_Info
                             {

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
