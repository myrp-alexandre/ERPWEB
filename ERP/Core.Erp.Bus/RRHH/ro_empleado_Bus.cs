using Core.Erp.Bus.General;
using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH;
using System;
using System.Collections.Generic;

namespace Core.Erp.Bus.RRHH
{
    public class ro_empleado_Bus
    {
        ro_empleado_Data odata = new ro_empleado_Data();
        tb_persona_Bus bus_persona = new tb_persona_Bus();
        public List<ro_empleado_Info> get_list_combo(int IdEmpresa)
        {
            try
            {
                return odata.get_list_combo(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<ro_empleado_Info> get_list_combo_liquidar(int IdEmpresa)
        {
            try
            {
                return odata.get_list_combo_liquidar(IdEmpresa);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<ro_empleado_Info> get_list(int IdEmpresa, bool estado)
        {
            try
            {
                return odata.get_list(IdEmpresa, estado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ro_empleado_Info get_info(int IdEmpresa, decimal IdEmpleado)
        {
            try
            {
                return odata.get_info(IdEmpresa, IdEmpleado);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ro_empleado_Info info)
        {
            try
            {
                info.IdSucursal = 1;
                bool si_grabo = false;
                info.info_persona.pe_Naturaleza = "NATU";
                info.info_persona.pe_nombreCompleto = info.info_persona.pe_apellido + " " + info.info_persona.pe_nombre;
                info.info_persona.pe_razonSocial = info.info_persona.pe_apellido + " " + info.info_persona.pe_nombre;
                decimal IdPersona = bus_persona.validar_existe_cedula(info.info_persona.pe_cedulaRuc);
                if (IdPersona != 0)
                {
                    info.info_persona.IdPersona = IdPersona;
                  si_grabo=  bus_persona.modificarDB(info.info_persona);
                }
                else
                {
                    info.info_persona.pe_Naturaleza = "NATU";
                    info.info_persona.pe_nombreCompleto = info.info_persona.pe_apellido + " " + info.info_persona.pe_nombre;
                    info.info_persona.pe_razonSocial = info.info_persona.pe_apellido + " " + info.info_persona.pe_nombre;
                    si_grabo = bus_persona.guardarDB(info.info_persona);
                }
                if(si_grabo)
                {
                    odata = new ro_empleado_Data();
                    info.em_estado = "A";
                    info.IdPersona = info.info_persona.IdPersona;
                    si_grabo= odata.guardarDB(info);
                }
                return si_grabo;
            }
            catch (Exception )
            {

                throw;
            }
        }

        public bool modificarDB(ro_empleado_Info info)
        {

            try
            {
                info.IdSucursal = 1;
                bool si_grabo = false;
                info.info_persona.pe_Naturaleza = "NATU";
                info.info_persona.pe_nombreCompleto = info.info_persona.pe_apellido + " " + info.info_persona.pe_nombre;
                info.info_persona.pe_razonSocial = info.info_persona.pe_apellido + " " + info.info_persona.pe_nombre;
                if (info.info_persona.IdPersona != 0)
                {
                    si_grabo = bus_persona.modificarDB(info.info_persona);
                }
               
                if (si_grabo)
                {
                    odata = new ro_empleado_Data();
                    info.em_estado = "A";
                    si_grabo = odata.modificarDB(info);
                }
                return si_grabo;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(ro_empleado_Info info)
        {
            try
            {
                return odata.anularDB(info);
            }
            catch (Exception)
            {

                throw;
            }
        }

       
    }
}
