﻿using Core.Erp.Info.Reportes.ActivoFijo;
using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Erp.Data.Reportes.Inventario
{
    public class ACTF_006_Data
    {
        public List<ACTF_006_Info> get_list(int IdEmpresa, decimal IdActivoFijo)
        {
            try
            {
                List<ACTF_006_Info> Lista=new List<ACTF_006_Info>();
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Lista = Context.Af_Activo_fijo.Where(q => q.IdEmpresa == IdEmpresa && q.IdActivoFijo == IdActivoFijo).Select(q => new ACTF_006_Info
                    {
                        IdEmpresa=q.IdEmpresa,
                        IdActivoFijo=q.IdActivoFijo,
                        CodActivoFijo=q.CodActivoFijo,
                        Af_Nombre=q.Af_Nombre,
                        Af_Codigo_Barra=q.Af_Codigo_Barra
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
