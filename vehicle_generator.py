import random
import string

REGIONAL_CODES = [
    50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
]

VEHICLES = {
    # ── Cars ────────────────────────────────────────────────────────────────
    "Toyota":    {"type": "car",        "models": ["Vios", "Camry", "Fortuner", "Innova", "Corolla Cross", "Hilux"],          "capacities": [1.5, 1.8, 2.0, 2.4, 2.7]},
    "Honda":     {"type": "car",        "models": ["City", "Civic", "CR-V", "HR-V", "Accord", "BR-V"],                       "capacities": [1.5, 1.8, 2.0]},
    "Hyundai":   {"type": "car",        "models": ["Accent", "Elantra", "Tucson", "Santa Fe", "Creta", "i10"],               "capacities": [1.4, 1.6, 2.0, 2.2, 2.5]},
    "Kia":       {"type": "car",        "models": ["Morning", "Soluto", "K3", "Seltos", "Sportage", "Carnival"],              "capacities": [1.0, 1.4, 1.6, 2.0, 2.2]},
    "Mazda":     {"type": "car",        "models": ["Mazda2", "Mazda3", "CX-3", "CX-5", "CX-8", "BT-50"],                    "capacities": [1.5, 1.8, 2.0, 2.2, 2.5]},
    "Ford":      {"type": "car",        "models": ["EcoSport", "Escape", "Ranger", "Everest", "Territory", "Transit"],        "capacities": [1.5, 2.0, 2.2, 2.3, 3.5]},
    "Mitsubishi":{"type": "car",        "models": ["Attrage", "Xpander", "Outlander", "Triton", "Pajero Sport"],              "capacities": [1.2, 1.5, 2.0, 2.4, 2.5]},
    "VinFast":   {"type": "car",        "models": ["Fadil", "Lux A2.0", "Lux SA2.0", "VF3", "VF5", "VF6", "VF8", "VF9"],   "capacities": [1.4, 2.0]},
    "Suzuki":    {"type": "car",        "models": ["Swift", "Ciaz", "Ertiga", "XL7", "Vitara"],                              "capacities": [1.2, 1.4, 1.5, 1.6]},
    "Peugeot":   {"type": "car",        "models": ["208", "2008", "3008", "5008", "408"],                                    "capacities": [1.2, 1.5, 1.6, 2.0]},

    # ── Honda Motorcycles ────────────────────────────────────────────────────
    "Honda Moto":{"type": "motorcycle", "models": [
                    "Wave Alpha", "Wave RSX", "Wave 110",           # underbone commuters
                    "Future 125", "Future Neo",                     # semi-auto commuters
                    "Air Blade 125", "Air Blade 150",               # scooters
                    "Vario 125", "Vario 150",
                    "Vision 110",
                    "Lead 125",
                    "SH 125i", "SH 150i", "SH Mode 125",           # premium scooters
                    "PCX 125", "PCX 150",
                    "CB150R", "CB300R", "CB500F",                   # naked sports
                    "CBR300R", "CBR500R", "CBR650R",                # sport bikes
                    "Winner X 150",                                 # sport commuter
                    "XR150L",                                       # adventure/trail
                    "CRF300L",
                ],
                "capacities": [0.110, 0.125, 0.150, 0.300, 0.500, 0.650]},
}

COLORS = [
    "Trắng", "Đen", "Bạc", "Xám", "Đỏ",
    "Xanh dương", "Xanh lá", "Vàng", "Cam", "Nâu",
    "Tím", "Hồng", "Vàng cát", "Xanh navy", "Đỏ đô",
]


def generate_plate(letter_count: int = None) -> str:
    region    = random.choice(REGIONAL_CODES)
    n_letters = letter_count or random.randint(1, 3)
    letters   = "".join(random.choices(string.ascii_uppercase, k=n_letters))
    left      = random.randint(0, 999)
    right     = random.randint(0, 99)
    return f"{region}{letters}-{left:03d}.{right:02d}"


def generate_vehicle(letter_count: int = None, vehicle_type: str = None) -> dict:
    """
    vehicle_type: 'car' | 'motorcycle' | None (random)
    """
    pool = {k: v for k, v in VEHICLES.items() if vehicle_type is None or v["type"] == vehicle_type}
    make     = random.choice(list(pool.keys()))
    info     = pool[make]
    model    = random.choice(info["models"])
    capacity = random.choice(info["capacities"])
    color    = random.choice(COLORS)
    plate    = generate_plate(letter_count)

    # Format capacity: motorcycles in cc, cars in L
    if info["type"] == "motorcycle":
        cap_str = f"{int(capacity * 1000)}cc"
    else:
        cap_str = f"{capacity}L"

    return {
        "plate":    plate,
        "type":     info["type"],
        "make":     make,
        "model":    model,
        "color":    color,
        "capacity": cap_str,
    }


def generate_batch(n: int = 10, **kwargs) -> list[dict]:
    return [generate_vehicle(**kwargs) for _ in range(n)]


if __name__ == "__main__":
    batch = generate_batch(20)

    header = f"{'Plate':<15} {'Type':<12} {'Make':<14} {'Model':<18} {'Color':<15} {'Capacity'}"
    print(header)
    print("-" * 85)
    for v in batch:
        print(f"{v['plate']:<15} {v['type']:<12} {v['make']:<14} {v['model']:<18} {v['color']:<15} {v['capacity']}")

    print("\n=== Motorcycles only ===")
    for v in generate_batch(5, vehicle_type="motorcycle"):
        print(f"{v['plate']:<15} {v['make']:<14} {v['model']:<18} {v['color']:<15} {v['capacity']}")