﻿using Core.Erp.Data.Reportes.RRHH;
using Core.Erp.Info.Reportes.RRHH;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.Reportes.RRHH
{
    public class ROL_009_Bus
    {
        ROL_009_Data odata = new ROL_009_Data();

        public List<ROL_009_Info> get_list(int IdEmpresa, DateTime fecha_inicio, DateTime fecha_fin, string estado_novedad, string IdRubro, decimal IdEmpleado)
        {
            try
            {
                return odata.get_list(IdEmpresa, fecha_inicio, fecha_fin, estado_novedad,IdRubro, IdEmpleado);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
